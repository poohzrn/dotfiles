let mapleader="\<Space>"
" Plugins {{{ "
call plug#begin()
" Plugin: 'jedi-vim' {{{
Plug 'davidhalter/jedi', {'for': 'python'} | Plug 'zchee/deoplete-jedi', {'for': 'python'}
"}}} "
" Plugin: 'autopep8' {{{
Plug 'tell-k/vim-autopep8', {'for': 'python'}          "autopep8
let g:autopep8_disable_show_diff=1
"}}} "
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
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" }}}
" {{{Plugin: 'lightline.vim'
Plug 'itchyny/lightline.vim'        "Neat information line
set laststatus=2
set statusline+=%#warningmsg#
set statusline+=%*
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
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
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
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
" Plugin: 'vim-fugitive' {{{
Plug 'tpope/vim-fugitive'           "Git integration
nnoremap <silent><leader>gd :Gdiff <CR>
nnoremap <silent><leader>st :Gstatus <CR>
nnoremap <silent><leader>gp :Gpull<CR>
nnoremap <silent>gc :Gcommit %:p <CR>i
nnoremap <silent>ga :Gcommit %:p --amend <CR>jo*
" }}}
" {{{Plugin: 'neomake'
Plug '~/git/neomake'           "asynchronous :make
"Toggle neomake list
nnoremap <F12> :call ToggleNeomakeList()<CR>
" let g:neomake_error_sign = {
"     \ 'texthl': 'ErrorMsg',
"     \ }
" let g:neomake_warning_sign = {
"     \ 'texthl': 'WarningMsg',
"     \ }
let g:neomake_open_list = 2
let g:neomake_tex_enabled_makers = ['lacheck', 'proselint']
let g:neomake_md_enabled_makers = ['proselint']
let g:neomake_python_enabled_makers = ['djangolint']
let g:neomake_cpp_clang_maker = {
            \ 'args': ['-std=c++11'],
            \}
autocmd! BufWritePost * Neomake
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
    autocmd BufRead,BufNewFile *.tex :map <buffer> <leader>v :VimtexView<CR>
    autocmd BufRead,BufNewFile *.tex :map <buffer> <leader>c :VimtexCompileToggle<CR>
    autocmd BufRead,BufNewFile *.tex :map <buffer> <leader>e :VimtexErrors<CR>
    autocmd BufRead,BufNewFile *.tex :map <buffer> <leader>l :VimtexLabelsToggle<CR>
    autocmd BufRead,BufNewFile *.tex :map <buffer> <leader>t :VimtexTocToggle<CR>
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
      \ 'Vertical rules in tables',
      \ 'specifier changed to',
      \ 'Command terminated with space.',
      \ 'LaTeX Font Warning',
      \ ]
let g:vimtex_viewer_zathura = 1
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_quickfix_autojump = 1
let g:vimtex_quickfix_mode = 1

autocmd FileType tex let b:vimtex_main = 'master.tex'

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
" Plugin: 'vim-gitgutter' {{{
Plug 'airblade/vim-gitgutter'          "diff

"}}} "
" Plugin: 'goyo.vim' {{{
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}          "yogo
noremap <silent><F1> :Goyo<cr>
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

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
"}}} "
" {{{Plugin: 'gruvbox'
"Plug 'morhetz/gruvbox'              "Colorscheme
" }}}
" Plugin: 'tender.vim' {{{
"Plug 'jacoborus/tender.vim'          "24-bit colorscheme

"}}} "
" Plugin: 'vim-colors-solarized' {{{
Plug 'altercation/vim-colors-solarized'          "Solarized colorscheme for vim

"}}} "
call plug#end()
" }}} Plugins "
" netrw {{{ "
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END
" }}} netrw "
" General Settings {{{
"=== Misc Settings ===
set path+=**
set smarttab
set lazyredraw
filetype plugin indent on
let python_highlight_all = 1
set noswapfile      "disable .swp files
set nobackup        "disable .swp files
set nowb            "disable .swp files
syntax enable       "enable syntax highlighting
syntax on
set list listchars=tab:\ \ ,trail:·     "Display tabs and trailing spaces visually
set number          "show line numbers
set ts=4            "set tabs to have 4 spaces
set autoindent      "indent when moving to the next line while writing code
set expandtab       "expand tabs into spaces
set shiftwidth=4    "when using the >> or << commands, shift lines by 4 spaces
set cursorline      "show a visual line under the cursor's current line
set showmatch
set rtp+=/home/lasse/.fzf
set so=8            "8 lines to the curser
set awa             "Write the contents of the file, auto
"https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim#L57-#L59
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif
" }}}
if exists('&inccommand')
  set inccommand=split
  nnoremap <C-s> :%s:
endif
" Wild menu and search {{{
set wildmenu
set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital
"set nohlsearch      " Noh after search
set gdefault        " when on, the :substitute flag 'g' is default on
set rnu             " Relative line numbers
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
set foldlevelstart=1
set foldtext=TxtFoldText()
function! TxtFoldText()
  let level = repeat('-', min([v:foldlevel-1,3])) . '+'
  let title = substitute(getline(v:foldstart), '{\{3}\d\?\s*', '', '')
  let title = substitute(title, '^["#! ]\+', '', '')
  return printf('%-4s %-s', level, title)
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
nnoremap <F4> :e $MYVIMRC<CR>
nnoremap <space> <nop>
noremap <space><space> zz
nnoremap <C-j> <c-w>j
nnoremap <C-h> <c-w>h
nnoremap <C-l> <c-w>l
nnoremap <C-k> <c-w>k
inoremap <CR>f <esc>
nnoremap <BS> <C-^>
" Follow the leader
nnoremap <leader>sp :setlocal spell! spelllang=en_us<CR>
nnoremap <leader>r z=
nnoremap <leader>w ]s
nnoremap <leader>b [s
nnoremap <leader>s :w <CR>
nnoremap <leader>j gjzz
nnoremap <leader>k gkzz
nnoremap <leader>o qp
nnoremap <leader>p @p
" Tabbing und buffering
nnoremap <leader>tn :tabnew<space>
nnoremap <leader>td :tabclose<CR>
nnoremap <leader>bh :sbprevious<CR>
nnoremap <leader>bl :sbnext<CR>
nnoremap <leader>bd :bdelete<CR>
" Create splits with empty buffers in all directions
nnoremap <leader>nh :leftabove  vnew<CR>
nnoremap <leader>nl :rightbelow vnew<CR>
nnoremap <leader>nk :leftabove  new<CR>
nnoremap <leader>nj :rightbelow new<CR>
" For completion completion
inoremap <C-j> <C-N>
inoremap <C-k> <C-P>
nnoremap <leader>del :call StripTrailingWhitespace()<CR>
" Explorer
nnoremap <F11> :Lexplore<CR>
" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
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
" Au groups {{{ "
"  Return to same line {{{
augroup line_return
au!
au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     execute 'normal! g`"zvzz' |
    \ endif
augroup END
" }}}
augroup VimReload
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
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
" }}} Au groups "
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
        echo "neomake_open_list=" . g:neomake_open_list
    elseif empty(getloclist(0))
        echo "no loclist"
    else
        let g:neomake_open_list=0
        lclose
        echo "neomake_open_list=" . g:neomake_open_list
    endif
endfunction
" }}} neomakeListToggle
" StripTrailingWhitespace {{{ "
function! StripTrailingWhitespace()
  if !&binary && &filetype != 'diff'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction
" }}} StripTrailingWhitespace "
" ColorScheme {{{ "
" set termguicolors
" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" set t_Co=256
syntax enable
set background=light
colorscheme solarized
" }}} ColorScheme "

" vim: fdm=marker
