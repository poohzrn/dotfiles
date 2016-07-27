#!/usr/bin/env python3
#
#   Copyright (c) 2016 James Murphy
#   Licensed under the GPL version 2 only
#
# monitor_manager is an i3blocks blocklet script to quickly manage your
# connected output devices


from tkinter import *
from tkinter import messagebox
from shutil import which
import tkinter.font as font
from subprocess import call, check_output, CalledProcessError
import re
import os

DESKTOP_SYMBOL = "\uf108"

UP_ARROW = "\uf062"
DOWN_ARROW = "\uf063"
UNBLANKED_SYMBOL = "\uf06e"
BLANKED_SYMBOL = "\uf070"
NOT_CLONED_SYMBOL = "\uf096"
PRIMARY_SYMBOL = "\uf005"
SECONDARY_SYMBOL = "\uf006"
CLONED_SYMBOL = "\uf24d"
TOGGLE_ON = "\uf205"
TOGGLE_OFF = "\uf204"
APPLY_SYMBOL = "\uf00c"
CANCEL_SYMBOL = "\uf00d"
ARANDR_SYMBOL = "\uf085"
REFRESH_SYMBOL = "\uf021"

FONTAWESOME_FONT_FAMILY = "FontAwesome"
FONTAWESOME_FONT_SIZE = 11
FONTAWESOME_FONT = (FONTAWESOME_FONT_FAMILY, FONTAWESOME_FONT_SIZE)
DEFAULT_FONT_FAMILY = "DejaVu Sans Mono"
DEFAULT_FONT_SIZE = 11
DEFAULT_FONT = (DEFAULT_FONT_FAMILY, DEFAULT_FONT_SIZE)

BUFFER = 20

class Output:
    def __init__(self, name=None, w=None, h=None, x=None, y=None, rate=None,
            active=False, primary=False, sameAs=None, blanked=False):
        self.name = name
        self.w = w
        self.h = h
        self.x = x
        self.y = y
        self.rate = rate
        self.active = active
        self.primary = primary
        self.sameAs = sameAs
        self.blanked = blanked
        self.modes = []
        self.currentModeIndex = None
        self.preferredModeIndex = None
        self.row = None

    def setPreferredMode(self):
        if self.preferredModeIndex != None:
            self.setMode(self.preferredModeIndex)
        elif self.modes != None:
            self.setMode(0)

    def setMode(self, index):
        self.w, self.h, self.rate = self.modes[index]
        self.currentModeIndex = index

    def realOutputs():
        outputs = []
        xrandrText = check_output(["xrandr","--verbose"],universal_newlines=True)
        outputBlocks = re.split(r'\n(?=\S)', xrandrText, re.MULTILINE)
        infoPattern = re.compile(r'^(\S+) connected (primary )?((\d+)x(\d+)\+(\d+)\+(\d+))?')
        brightnessPattern = re.compile(r'^\tBrightness: ([\d.]+)', re.MULTILINE)
        modePattern = re.compile(r'^  (\d+)x(\d+)[^\n]*?\n +h:[^\n]*?\n +v:[^\n]*?([\d.]+)Hz$', re.MULTILINE)
        for outputBlock in outputBlocks:
            output = Output()
            infoMatch = infoPattern.match(outputBlock)
            if infoMatch:
                output.name = infoMatch.group(1)
                if infoMatch.group(2):
                    output.primary = True
                if infoMatch.group(3):
                    output.active = True
                    output.w, output.h, output.x, output.y = map(int,infoMatch.group(4, 5, 6, 7))
                brightnessMatch = brightnessPattern.search(outputBlock)
                if brightnessMatch:
                    try:
                        brightness = float(brightnessMatch.group(1))
                        if abs(brightness) < 1e-09:
                            output.blanked = True
                    except ValueError:
                        pass
                modeMatches = modePattern.finditer(outputBlock)
                for i, modeMatch in enumerate(modeMatches):
                    if "*current" in modeMatch.group(0):
                        output.currentModeIndex = i
                        output.rate = modeMatch.group(3)
                    if "+preferred" in modeMatch.group(0):
                        output.preferredModeIndex = i
                    output.modes.append(modeMatch.group(1,2,3))
                outputs.append(output)
        outputs.sort(key=lambda m: m.x if m.x != None else -1)
        prev = None
        for output in outputs:
            if prev != None and output.active and prev.active and output.x == prev.x:
                output.sameAs = prev.name
            else:
                prev = output

        return outputs

    def modestr(mode):
        return "{}x{}@{}".format(*mode)

    def status(self):
        if self.active:
            if self.sameAs == None or self.sameAs == self.name:
                if self.w and self.h and self.rate:
                    return "{}x{}@{}".format(self.w, self.h, self.rate)
                else:
                    return "auto"
            else:
                return "duplicate {}".format(self.sameAs)
        else:
            return "Inactive"


    def __str__(self):
        return "{} {}x{}+{}+{} active:{}, primary:{}\nmodes:{}\ncurrentIndex:{} preferredIndex:{}".format(
                self.name, self.w, self.h, self.x, self.y, self.active, self.primary, self.modes, self.currentModeIndex, self.preferredModeIndex)

class MonitorManager():
    def __init__(self, root):
        self.root = root
        self.root.withdraw()
        self.root.resizable(0,0)
        self.root.wm_title("Monitor Manager")
        self.frame = None
        self.outputs = []
        self.hardRefreshList()
        style = {'relief':FLAT, 'padx':1, 'pady':1, 'anchor':'w', 'font':FONTAWESOME_FONT}

        self.infoLabel = Label(self.root, text="", **style)
        self.infoLabel.config(font=DEFAULT_FONT)

        self.bottomRow = []

        self.applyButton = Button(self.root, text=APPLY_SYMBOL, **style)
        self.bottomRow.append(self.applyButton)

        self.refreshButton = Button(self.root, text=REFRESH_SYMBOL, **style)
        self.bottomRow.append(self.refreshButton)

        if which("arandr"):
            self.arandrButton = Button(self.root, text=ARANDR_SYMBOL, **style)
            self.bottomRow.append(self.arandrButton)
        else:
            self.arandrButton = None

        self.cancelButton = Button(self.root, text=CANCEL_SYMBOL, **style)
        self.bottomRow.append(self.cancelButton)

        self.infoLabel.grid(row=1,column=0, columnspan=len(self.bottomRow))
        self.gridRow(2, self.bottomRow)

        self.moveToMouse()
        self.root.deiconify()

    def registerBindings(self):
        self.root.bind("<Return>", self.handleApply)
        self.root.bind("<Escape>", self.handleCancel)

        self.applyButton.bind("<Button-1>", self.handleApply)
        self.setInfo(self.applyButton, "Apply changes")

        self.refreshButton.bind("<Button-1>", self.hardRefreshList)
        self.setInfo(self.refreshButton, "Refresh list")

        if self.arandrButton:
            self.arandrButton.bind("<Button-1>", self.handleArandr)
            self.setInfo(self.arandrButton, "Launch aRandR")

        self.cancelButton.bind("<Button-1>", self.handleCancel)
        self.setInfo(self.cancelButton, "Cancel")

        for toggleButton in self.toggleButtons:
            toggleButton.bind("<Button-1>", self.toggleActive)
            toggleButton.bind("<Button-4>", self.handleUp)
            toggleButton.bind("<Button-5>", self.handleDown)
            self.setInfo(toggleButton, "Turn output on/off")

        for primaryButton in self.primaryButtons:
            primaryButton.bind("<Button-1>", self.setPrimary)
            self.setInfo(primaryButton, "Set primary output")

        for blankedButton in self.blankedButtons:
            blankedButton.bind("<Button-1>", self.toggleBlanked)
            self.setInfo(blankedButton, "Show/hide output")

        for duplicateButton in self.duplicateButtons:
            duplicateButton.bind("<Button-1>", self.toggleDuplicate)
            self.setInfo(duplicateButton, "Extend/duplicate output")

        for upButton in self.upButtons:
            upButton.bind("<Button-1>", self.handleUp)
            upButton.bind("<Button-4>", self.handleUp)
            upButton.bind("<Button-5>", self.handleDown)

        for downButton in self.downButtons:
            downButton.bind("<Button-1>", self.handleDown)
            downButton.bind("<Button-4>", self.handleUp)
            downButton.bind("<Button-5>", self.handleDown)

    def gridRow(self, row, widgets):
        column = 0
        for w in widgets:
            w.grid(row=row, column=column)
            column += 1

    def moveToMouse(self):
        root = self.root
        root.update_idletasks()
        width = root.winfo_reqwidth()
        height = root.winfo_reqheight()
        x = root.winfo_pointerx() - width//2
        y = root.winfo_pointery() - height//2
        screen_width = root.winfo_screenwidth()
        screen_height = root.winfo_screenheight()
        if x+width > screen_width - BUFFER:
            x =  screen_width - BUFFER - width
            print("x adj")
        elif x < BUFFER:
            x = BUFFER
        if y+height > screen_height - BUFFER:
            y = screen_height - BUFFER - height
        elif y < BUFFER:
            y = BUFFER

        root.geometry('+{}+{}'.format(x, y))

    def setInfo(self, widget, info):
        widget.bind("<Enter>", lambda e: self.infoLabel.config(text=info, fg="black"))
        widget.bind("<Leave>", lambda e: self.infoLabel.config(text=""))

    def handleApply(self, e=None):
        self.root.after_idle(self.doHandleApply)

    def doHandleApply(self):
        if not self.getUserConfirmationIfDangerousConfiguration():
            return
        command = ["xrandr"]
        partition = self.sameAsPartition()
        prevFirstActive = None
        for p in partition:
            firstActive = None
            for output in p:
                command += ["--output", output.name]
                if output.active:
                    if firstActive == None:
                        firstActive = output
                    else:
                        command += ["--same-as", firstActive.name]
                    if output.primary:
                        command += ["--primary"]
                    if prevFirstActive != None:
                        command += ["--right-of", prevFirstActive.name]
                    if output.w != None and output.h != None and output.rate != None:
                        command += ["--mode", "{}x{}".format(output.w,output.h)]
                        command += ["--rate", output.rate ]
                    else:
                            command += ["--auto"]
                    if output.blanked:
                        command += ["--brightness", "0"]
                    else:
                        command += ["--brightness", "1"]
                else:
                    command += ["--off"]
                try:
                    check_output(command, universal_newlines=True)
                except CalledProcessError as err:
                    self.infoLabel.config(text="xrandr returned nonzero exit status {}".format(err.returncode), fg="red")
            if firstActive:
                prevFirstActive = firstActive

    def getUserConfirmationIfDangerousConfiguration(self):
        result = "yes"
        if all(map(lambda o: o.blanked or not o.active, self.outputs)):
            result = messagebox.askquestion("All blanked or off",
                    "All ouputs are set to be turned off or blanked, continue?",
                    icon="warning")
        return result == "yes"

    def sameAsPartition(self):
        partition = []
        for output in self.outputs:
            place = None
            for p in partition:
                if place != None:
                    break;
                for o in p:
                    if place == None and (output.sameAs == o.name or o.sameAs == output.name):
                        place = p
                        break;
            if place:
                place.append(output)
            else:
                partition.append([output])
        return partition


    def handleCancel(self, e=None):
        self.root.destroy()

    def handleArandr(self, e=None):
        call(["i3-msg", "exec", "arandr"])
        self.root.destroy()

    def handleUp(self, e):
        row = e.widget.output.row
        if row > 0:
            self.swapOutputRows(row-1, row)
        self.softRefreshList()

    def handleDown(self, e):
        row = e.widget.output.row
        n = len(self.outputs)
        if row + 1 < n:
            self.swapOutputRows(row, row+1)
        self.softRefreshList()

    def swapOutputRows(self, row1, row2):
        outputs = self.outputs
        outputs[row1],outputs[row2] = outputs[row2],outputs[row1]
        outputs[row1].row = row1
        outputs[row2].row = row2
        for widget in self.frame.grid_slaves(row=row2):
            widget.output = outputs[row2]
        for widget in self.frame.grid_slaves(row=row1):
            widget.output = outputs[row1]

    def setPrimary(self, e):
        output = e.widget.output
        for otherOutput in self.outputs:
            otherOutput.primary = (otherOutput == output)
        self.softRefreshList()

    def toggleActive(self, e):
        output = e.widget.output
        output.active = not output.active
        if output.active:
            output.setPreferredMode()
        else:
            for otherOutput in self.outputs:
                if otherOutput.sameAs == output.name:
                    otherOutput.sameAs = None
        self.softRefreshList()

    def toggleBlanked(self, e):
        output = e.widget.output
        output.blanked = not output.blanked
        self.softRefreshList()

    def toggleDuplicate(self, e):
        duplicateButton = e.widget
        optionMenu = duplicateButton.statusOptionMenu
        output = optionMenu.output
        if output.sameAs != None:
            output.sameAs = None
            self.setMenuToOutput(optionMenu, output)
        else:
            self.setMenuToDuplicate(optionMenu)
        self.softRefreshList()

    def getDuplicableOutputsFor(self, output):
        return [o for o in self.outputs if o != output and o.sameAs == None]

    def softRefreshList(self, e=None):
        for widget in set().union(self.nameLabels, self.primaryButtons,
                self.statusOptionMenus, self.blankedButtons,
                self.duplicateButtons, self.upButtons, self.downButtons):
            widget.config(fg="gray" if not widget.output.active else "black")

        for widget in self.toggleButtons:
            widget.config(text=TOGGLE_ON if widget.output.active else TOGGLE_OFF)

        for widget in self.nameLabels:
            widget.config(text=widget.output.name)

        for widget in self.primaryButtons:
            widget.config(text=PRIMARY_SYMBOL if widget.output.primary else SECONDARY_SYMBOL)
            if not widget.output.primary:
                widget.config(fg="gray")

        for widget in self.statusOptionMenus:
            widget.config(text=widget.output.status())
            if widget.output.sameAs != None:
                self.setMenuToDuplicate(widget)
                self.setInfo(widget, "Select output to duplicate")
            else:
                self.setMenuToOutput(widget, widget.output)
                self.setInfo(widget, "Select output mode")

        for widget in self.blankedButtons:
            widget.config(text=BLANKED_SYMBOL if widget.output.blanked else UNBLANKED_SYMBOL)

        for widget in self.duplicateButtons:
            widget.config(text=CLONED_SYMBOL if widget.output.sameAs else NOT_CLONED_SYMBOL)

    def hardRefreshList(self, e=None):
        self.outputs = Output.realOutputs()
        self.root.after_idle(self.populateGrid)

    def populateGrid(self):
        oldFrame = self.frame
        self.frame = Frame(self.root)
        self.frame.grid(row=0, column=0, columnspan=len(self.bottomRow))
        self.toggleButtons = []
        self.nameLabels = []
        self.primaryButtons = []
        self.statusOptionMenus = []
        self.blankedButtons = []
        self.duplicateButtons = []
        self.upButtons = []
        self.downButtons = []
        for row, output in enumerate(self.outputs):
            self.makeLabelRow(output, row)
        self.registerBindings()
        if oldFrame:
            oldFrame.destroy()

    def makeLabelRow(self, output, row):
        output.row = row
        style = {'relief':FLAT, 'padx':1, 'pady':1, 'anchor':'w'}

        toggleButton = Button(self.frame, font=FONTAWESOME_FONT, **style)
        self.toggleButtons.append(toggleButton)

        nameLabel = Label(self.frame, font=DEFAULT_FONT)
        self.nameLabels.append(nameLabel)

        primaryButton = Button(self.frame, font=FONTAWESOME_FONT, **style)
        self.primaryButtons.append(primaryButton)
        if not output.primary:
            primaryButton.config(fg="gray")

        var = StringVar(self.frame)
        statusOptionMenu = OptionMenu(self.frame, var, None)
        statusOptionMenu.var = var
        statusOptionMenu.config(relief=FLAT)
        self.statusOptionMenus.append(statusOptionMenu)
        if output.sameAs != None:
            self.setMenuToDuplicate(statusOptionMenu)
        else:
            self.setMenuToOutput(statusOptionMenu, output)

        blankedButton = Button(self.frame, font=FONTAWESOME_FONT,  **style)
        self.blankedButtons.append(blankedButton)

        duplicateButton = Button(self.frame, font=FONTAWESOME_FONT, **style)
        duplicateButton.statusOptionMenu = statusOptionMenu
        self.duplicateButtons.append(duplicateButton)

        upButton = Button(self.frame, text=UP_ARROW, font=FONTAWESOME_FONT, **style)
        self.upButtons.append(upButton)

        downButton = Button(self.frame, text=DOWN_ARROW, font=FONTAWESOME_FONT, **style)
        self.downButtons.append(downButton)

        widgets = [toggleButton, nameLabel, primaryButton,  statusOptionMenu,
                blankedButton, duplicateButton, upButton, downButton]
        for widget in widgets:
            widget.output = output
        self.gridRow(row, widgets)
        self.softRefreshList()

    def setMenuToOutput(self, optionMenu, output):
        menu = optionMenu["menu"]
        var = optionMenu.var
        modes = output.modes
        menu.delete(0, END)
        for i, mode in enumerate(modes):
            label = Output.modestr(mode)
            menu.add_command(label=label, command=setLabelAndOutputModeFunc(var,label,output,i))
        if output.currentModeIndex != None:
            var.set(Output.modestr(modes[output.currentModeIndex]))
        elif output.preferredModeIndex != None:
            var.set(Output.modestr(modes[output.preferredModeIndex]))
        elif len(modes) > 0:
            var.set(Output.modestr(modes[0]))

    def setMenuToDuplicate(self, optionMenu):
        menu = optionMenu["menu"]
        var = optionMenu.var
        output = optionMenu.output
        menu.delete(0, END)
        duplicables = self.getDuplicableOutputsFor(output)
        for otherOutput in duplicables:
                label = otherOutput.name
                menu.add_command(label=label, command=setLabelAndSameAsFunc(var,label,otherOutput))
        if len(duplicables) > 0:
            var.set(menu.entrycget(0, "label"))
            output.sameAs = menu.entrycget(0, "label")
        else:
            var.set("None")

    def handleFocusOut(self, event):
        self.root.destroy()

def setLabelAndOutputModeFunc(var, label, output, i):
    def func():
        var.set(label)
        output.setMode(i)
    return func

def setLabelAndSameAsFunc(var, sameAs, output):
    def func():
        var.set(sameAs)
        output.sameAs = sameAs
    return func

if os.environ.get('BLOCK_BUTTON') == "1":
    if os.fork() != 0:
        root = Tk()
        if DEFAULT_FONT_FAMILY and DEFAULT_FONT_SIZE:
            font.nametofont("TkDefaultFont").config(family=DEFAULT_FONT_FAMILY, size=DEFAULT_FONT_SIZE)
        manager = MonitorManager(root)
        root.mainloop()
    else:
        print(DESKTOP_SYMBOL)
else:
    print(DESKTOP_SYMBOL)