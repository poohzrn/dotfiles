let g:mapleader="\<Space>"
" Plugins {{{ "
call plug#begin()
" Python Plugins {{{ "
" Plugin: 'jedi-vim' {{{
Plug 'davidhalter/jedi', {'for': 'python'}
"}}} "
" Plugin: 'deoplete-jedi' {{{
Plug 'zchee/deoplete-jedi', {'for': 'python'}

"}}} "
" Plugin: 'autopep8' {{{
Plug 'tell-k/vim-autopep8', {'for': 'python'}          "autopep8
let g:autopep8_disable_show_diff=1
"}}} "

" }}} Python Plugins "
" Plugin: 'deoplete.nvim' {{{
Plug 'Shougo/deoplete.nvim'
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_refresh_always = 1
" }}}
" Plugin: 'supertab' {{{
Plug 'ervandew/supertab'            "Super tab
let g:SuperTabDefaultCompletionType = '<C-n>'
" }}}
" Plugin: 'ultisnips' {{{
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
" }}}
" {{{ Plugin: 'fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'
nnoremap <C-f><C-f> :Files<CR>
nnoremap <C-f><C-g> :GitFiles<CR>
nnoremap <C-f><C-a> :Ag<CR>
nnoremap <C-f><C-l> :BLines <CR>
nnoremap <C-f><C-t> :Tags <CR>
nnoremap <C-f><C-w> :Buffers <CR>
nnoremap <C-f><C-h> :History <CR>
cnoremap W w

nmap <leader><tab> <plug>(fzf-maps-n)
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-s': 'split',
            \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '25%' }
let g:fzf_colors = {
            \ 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" }}}
"{{{ Plugin: 'neomake'
Plug 'neomake/neomake', {'for': 'tex'}           "asynchronous :make
"Toggle neomake list
nnoremap <F12> :call ToggleNeomakeList()<CR>
let g:neomake_open_list = 0
let g:neomake_tex_enabled_makers = ['chktex', 'lacheck', 'proselint']
augroup NEOMAKE
    autocmd! BufWritePost *.tex Neomake
augroup end
" }}}
" Plugin: 'vim-repeat' {{{
Plug 'tpope/vim-repeat'          " .
" }}}
" Plugin: 'vimtex' {{{
Plug 'lervag/vimtex', {'for': 'tex' }          "A modern vim plugin for editing LaTeX
"Toggle comilation
augroup SET_TEX
    autocmd BufRead,BufNewFile *.tex set ft=tex
    autocmd BufRead,BufNewFile *.tex set spell spelllang=en_us
    autocmd BufRead,BufNewFile *.tex setlocal formatoptions-=a
    autocmd BufWritePost,BufNewFile *.tex setlocal formatoptions-=a
    autocmd FileType tex let b:vimtex_main = 'master.tex'
augroup end
let g:tex_flavor = 'latex'
set foldtext=vimtex#fold#text()
let g:vimtex_fold_enabled = 1
let g:vimtex_fold_manual = 1
let g:vimtex_fold_sections = [
            \ 'part',
            \ 'chapter',
            \ 'section',
            \ 'subsection',
            \ 'subsubsection',
            \ 'question',
            \ ]
let g:vimtex_quickfix_ignored_warnings = [
            \ 'Underfull',
            \ 'Overfull',
            \ 'specifier changed to',
            \ 'Command terminated with space.',
            \ 'LaTeX Font Warning',
            \ ]
let g:vimtex_viewer_zathura = 1
let g:vimtex_view_general_viewer = 'zathura'
" let g:vimtex_view_general_viewer = 'okular'
" let g:vimtex_view_general_options = '--unique @pdf\#src:@line@tex'
" let g:vimtex_view_general_options_latexmk = '--unique'

let g:vimtex_quickfix_autojump = 1
let g:vimtex_quickfix_mode = 2
if !exists('g:deoplete#omni_patterns')
    let g:deoplete#omni_patterns = {}
endif
let g:deoplete#omni_patterns.tex =
            \ '\v\\%('
            \ . '\a*cite\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
            \ . '|\a*ref%(\s*\{[^}]*|range\s*\{[^,}]*%(}\{)?)'
            \ . '|hyperref\s*\[[^]]*'
            \ . '|includegraphics\*?%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
            \ . '|%(include%(only)?|input)\s*\{[^}]*'
            \ . '|\a*(gls|Gls|GLS)(pl)?\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
            \ . '|includepdf%(\s*\[[^]]*\])?\s*\{[^}]*'
            \ . '|includestandalone%(\s*\[[^]]*\])?\s*\{[^}]*'
            \ . ')\m'
    " }}}
" Plugin: 'vim-commentary' {{{
Plug 'tpope/vim-commentary', {'on': '<Plug>Commentary'}          "comments
if !hasmapto('<Plug>Commentary') || maparg('gc','n') ==# ''
    xmap cc  <Plug>Commentary
    nmap cc  <Plug>Commentary
    omap cc  <Plug>Commentary
endif
"}}} "
" Plugin: 'targets.vim' {{{
Plug 'wellle/targets.vim'          "additional text objects
"}}} "
" Plugin: 'ale' {{{
Plug 'w0rp/ale',  {'for': 'python'}          "Async linter
function! AleStatusLine() abort
    if (&ft != 'tex')
        return ALEGetStatusLine()
    endif
endfunction
let g:ale_echo_msg_error_str = 'E'
let g:ale_sign_column_always = 1
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%][%severity%]|%s'
let g:ale_statusline_format = ['E:%d', 'W:%d', '']
nmap <silent> <c-p> <Plug>(ale_previous_wrap)
nmap <silent> <c-n> <Plug>(ale_next_wrap)
"}}} "
" Plugin: 'bexec' {{{
Plug 'fboender/bexec'
"}}} "
" Plugin: 'tagbar' {{{
Plug 'majutsushi/tagbar'
nmap <F3> :TagbarToggle<CR>
"}}} "
" Git Plugins {{{ "
" Plugin: 'vim-fugitive' {{{
Plug 'tpope/vim-fugitive'           "Git integration
nnoremap <silent><leader>gd :Gdiff <CR>
nnoremap <silent><leader>st :Gstatus <CR>
nnoremap <silent><leader>gp :Gpull<CR>
nnoremap <silent>gc :Gcommit %:p <CR>i
nnoremap <silent>ga :Gcommit %:p --amend <CR>jo*
" }}}
" Plugin: 'vim-gitgutter' {{{
" Plug 'airblade/vim-gitgutter'
"}}} "
" }}} Git Plugins "
" UI {{{ "
" {{{Plugin: 'lightline.vim'
Plug 'itchyny/lightline.vim'        "Neat information line
set laststatus=2
set statusline+=%#warningmsg#
set statusline+=%*
let g:lightline = {
            \ 'colorscheme': 'solarized',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'fugitive', 'readonly', 'filename', 'modified', 'ale'] ]
            \ },
            \ 'component': {
            \   'readonly': '%{&filetype=="help"?"":&readonly?"RO":""}',
            \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
            \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
            \ },
            \ 'component_visible_condition': {
            \   'readonly': '(&filetype!="help"&& &readonly)',
            \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
            \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
            \ },
            \ }
" }}}
" Plugin: 'goyo.vim' {{{
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}          "yogo
nnoremap <silent><F11> :Goyo<cr>

function! s:goyo_enter()
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
    set noshowmode
    set noshowcmd
    set scrolloff=999
endfunction

function! s:goyo_leave()
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
    set showmode
    set showcmd
    set scrolloff=5
endfunction

augroup GOYO
    autocmd! User GoyoEnter nested call <SID>goyo_enter()
    autocmd! User GoyoLeave nested call <SID>goyo_leave()
augroup end
"}}} "
" Plugin: 'vim-startify' {{{
Plug 'mhinz/vim-startify'
let g:startify_custom_header = []
let g:startify_session_dir = '~/.vim/session'
nmap nnoremap <leader><F4> :Startify<CR>
let g:startify_bookmarks = [
            \ { 'c': '~/git/dotfiles/init.vim' },
            \ { 'sw10': '~/git/sw10-report/README.md' },
            \ ]
let g:startify_skiplist = [
      \ 'COMMIT_EDITMSG',
      \ 'bundle/.*/doc',
      \ ]
let g:startify_list_order = ['sessions', 'bookmarks', 'dir', 'files', 'commands']
let g:startify_list_order = [
        \ ['   Sessions:'],
        \ 'sessions',
        \ ['   Bookmarks:'],
        \ 'bookmarks',
        \ ['   MRU in dir:'],
        \ 'dir',
        \ ['   MRU:'],
        \ 'files',
        \ ]
let g:startify_change_to_dir          = 1
let g:startify_change_to_vcs_root     = 1
let g:startify_enable_special         = 0
let g:startify_files_number           = 5
let g:startify_fortune_use_unicode    = 1
let g:startify_session_autoload       = 0
let g:startify_session_persistence    = 1
let g:startify_update_oldfiles        = 1
let g:startify_use_env                = 1
"}}} "
" Plugin: 'vim-orgmode' {{{
Plug 'jceb/vim-orgmode'

"}}} "
" Plugin: 'vim-colors-solarized {{{ "
Plug 'altercation/vim-colors-solarized'
" }}} Plugin: 'vim-colors-solarized "
" Plugin: 'despacio' {{{
Plug 'alessandroyorba/despacio'          "colorscheme

"}}} "
" Plugin: 'winresizer' {{{
Plug 'simeji/winresizer'

"}}} "
" }}} UI "
call plug#end()
" }}} Plugins "
" netrw {{{ "
noremap <F1> :Lexplore<cr>
" :<>
augroup netrw_close
    autocmd!
    autocmd filetype netrw call NetrwClose()
augroup END

augroup nonvim
   au!
   au BufRead *.pdf sil exe "!zathura " . shellescape(expand("%:p")) . " &"| bd | let &ft=&ft
augroup end
function! NetrwClose()
    noremap <buffer> <F1> :bd<cr>
endfunction
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
" }}} netrw "
" General Settings {{{
"=== Misc Settings ===
set diffopt+=vertical
set path+=**
set smarttab
set lazyredraw
filetype plugin indent on
let g:python_highlight_all = 1
set noswapfile      "disable .swp files
set nobackup        "disable .swp files
set nowritebackup "disable .swp files
syntax enable       "enable syntax highlighting
syntax on
set list listchars=tab:\ \ ,trail:·     "Display tabs and trailing spaces visually
set number          "show line numbers
set tabstop=4            "set tabs to have 4 spaces
set autoindent      "indent when moving to the next line while writing code
set expandtab       "expand tabs into spaces
set shiftwidth=4    "when using the >> or << commands, shift lines by 4 spaces
set cursorline      "show a visual line under the cursor's current line
set showmatch
set runtimepath+=/home/lasse/.fzf
set scrolloff=8            "8 lines to the curser
set autowriteall             "Write the contents of the file, auto
"https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim#L57-#L59
if v:version > 703 || v:version == 703 && has('patch541')
    set formatoptions+=j " Delete comment character when joining commented lines
endif
if exists('&inccommand')
    set inccommand=split
    nnoremap <C-s> :%s:
endif
" }}}
" Wild menu and search {{{
set wildmenu
set wildignore+=tags,*.pyc,*.aux,*.dvi,*.log,*.toc,*.bbl,*.blg,*.gz,*.out,*.thm,*.ps,*.idx,*.ilg,*.ind,*.fdb_latexmk,*.tdo,*.fls,*.lox,*.ist,*.pdf
set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital
"set nohlsearch      " Noh after search
set gdefault        " when on, the :substitute flag 'g' is default on
set relativenumber             " Relative line numbers
nmap <silent> hs :set hlsearch!<CR>
" Replace previous search
nmap  S %s///g<left><left>
" }}}
" Persistent Undo {{{
" Keep undo history across sessions, by storing in file.
if has('persistent_undo')
    silent !mkdir -p ~/.vim/backups
    set undodir=~/.vim/backups
    set undofile
endif
" }}}
" Folding {{{
if &foldmethod ==# ''
    set foldmethod=syntax
endif
set foldlevel=0
set foldcolumn=0
set foldlevelstart=100
set foldtext=TxtFoldText()
function! TxtFoldText()
    let l:level = repeat('-', min([v:foldlevel-1,3])) . '+'
    let l:title = substitute(getline(v:foldstart), '{\{3}\d\?\s*', '', '')
    let l:title = substitute(l:title, '^["#! ]\+', '', '')
    return printf('%-4s %-s', l:level, l:title)
endfunction
" Navigate folds
nmap <tab> za
nnoremap zf zMzvzz
nnoremap zj zcjzvzz
nnoremap zk zckzvzz

" }}}
" Cursor configuration {{{
" Use a blinking upright bar cursor in Insert mode, a solid block in normal
" and a blinking underline in replace mode
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let &t_SI = "\<Esc>[5 q"
let &t_SR = "\<Esc>[3 q"
let &t_EI = "\<Esc>[ q"
" }}}"
" {{{1 Key Mapping
nnoremap <silent> <F2> :set invpaste paste?<CR>
nnoremap <space> <nop>
noremap <space><space> zz
nnoremap <C-j> <c-w>j
nnoremap <C-h> <c-w>h
nnoremap <C-l> <c-w>l
nnoremap <C-k> <c-w>k
inoremap <CR>f <esc>
inoremap jk <esc>
inoremap kj <esc>
nnoremap <BS> <C-^>
" Follow the leader
nnoremap <leader>sp :setlocal spell! spelllang=en_us<CR>
nnoremap <leader>spda :setlocal spell! spelllang=da<CR>
nnoremap <leader>w ]s
nnoremap <leader>b [s
nnoremap <leader>j gjzz
nnoremap <leader>k gkzz
" For completion completion
inoremap <C-j> <C-N>
inoremap <C-k> <C-P>
" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" Neat for tpyos
function! FixWord() abort
    if &spell
        normal! 1z=
    endif
endfunction
command! FixWord :call FixWord()
nnoremap <CR><CR> :FixWord<CR>
"1}}}
" Resizing {{{
nnoremap <leader>rh :vertical resize +10 <CR>
nnoremap <leader>rl :vertical resize -10 <CR>
nnoremap <leader>rj :resize +10 <CR>
nnoremap <leader>rk :resize -10 <CR>
" }}} Resizing "
" Copy/Paste {{{
vnoremap yy "+y
vnoremap dd "+d
vnoremap pp "+p
vnoremap PP "+P
nnoremap pp "+p
nnoremap PP "+P
" }}} Copy/Pase "
"  Augroups {{{
augroup line_return
    au!
    au BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \     execute 'normal! g`"zvzz' |
                \ endif
augroup END
augroup VIMRC
    autocmd!
    autocmd BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
    autocmd BufReadPost * silent! execute 'normal! g`"zzzv'
    autocmd BufWritePost * if &diff | diffupdate | endif
    autocmd InsertLeave * if bufname('%') != "[Command Line]" | pclose | endif
    " autocmd * qf wincmd L
augroup END
augroup ClearHighLight
    autocmd BufWrite * set nohlsearch
augroup end
augroup cursororline_only_on_focus
        autocmd!
        autocmd WinEnter * set cursorline
        autocmd WinLeave * set nocursorline
augroup END
" }}} Augroups
" Mode: Command {{{
cnoremap <C-a> <Home>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-d> <Delete>
cnoremap <C-e> <End>
" }}}
" Mode: Terminal {{{
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap <C-f> <C-c>
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
    tnoremap <A-l> <C-\><C-n><C-w>l
endif
" }}}
" neomakeListToggle {{{ "
function! ToggleNeomakeList()
    if g:neomake_open_list==0 && !empty(getloclist(0))
        let g:neomake_open_list=1
        lopen
        echo 'neomake_open_list=' . g:neomake_open_list
    elseif empty(getloclist(0))
        echo 'no loclist'
    else
        let g:neomake_open_list=0
        lclose
        echo 'neomake_open_list=' . g:neomake_open_list
    endif
endfunction
" }}} neomakeListToggle
" StripTrailingWhitespace {{{ "
function! StripTrailingWhitespace()
    if !&binary && &filetype != 'diff'
        normal! mz
        normal! Hmy
        %s/\s\+$//e
        normal! 'yz<CR>
        normal! `z
    endif
endfunction
command! StripTrailingWhitespace :call StripTrailingWhitespace()
nnoremap <leader>del :StripTrailingWhitespace<CR>

" }}} StripTrailingWhitespace "
" Set Background {{{ "
function! SetBackground() abort
    let l:time = abs(strftime("%H"))
    if l:time >= abs(18) || l:time < abs(9)
        set background=dark
    else
        set background=light
    endif
endfunction
function! BackgroundToggle() abort
    if &bg=='light'
        set bg=dark
    else
        set bg=light
    endif
endfunction
command! BackgroundColorSet :call SetBackground()
command! BackgroundColorToggle :call BackgroundToggle()
" augroup set_background_color
"     autocmd!
"     " autocmd BufRead,BufNewFile,BufEnter * BackgroundColorSet
" augroup END
" }}}
" ColorScheme {{{ "
syntax enable
colorscheme solarized
" }}} ColorScheme "

" vim: fdm=marker
