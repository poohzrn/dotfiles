let mapleader="\<Space>"
" Plugins {{{ "
call plug#begin()
" Plugin: 'braceless.vim' {{{
Plug 'tweekmonster/braceless.vim'          "Text objects, folding Python and other indented languages.
"Settings for braceless.vim
autocmd FileType python BracelessEnable +indent +highlight
"}}} "
" Plugin: 'jedi-vim' {{{
Plug 'davidhalter/jedi', {'for': 'python'} | Plug 'zchee/deoplete-jedi', {'for': 'python'}
"Settings for jedi-vim

"}}} "
" Plugin: 'deoplete.nvim' {{{
Plug 'Shougo/deoplete.nvim'
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_refresh_always = 1
" }}}
" " Plugin: 'supertab' {{{
" Plug 'ervandew/supertab'            "Super tab
" let g:SuperTabDefaultCompletionType = '<C-n>'
" " }}}
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
      \ 'colorscheme': 'gruvbox',
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
" {{{Plugin: 'gruvbox'
Plug 'morhetz/gruvbox'              "Colorscheme
set t_Co=256
set background=dark
" }}}
" Plugin: 'vim-buftabline' {{{
Plug 'ap/vim-buftabline'          "See current buffers
"Settings for vim-buftabline
set hidden
nnoremap <Leader>h :bprev<CR>
nnoremap <Leader>l :bnext<CR>
" }}}
" Plugin: 'vim-over' {{{
Plug 'osyo-manga/vim-over', {'on': 'OverCommandLine'}         " :substitute preview
"Settings for vim-over
nnoremap <C-s> :OverCommandLine <CR>%s:

" }}}
" {{{ Plugin: 'fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'
nnoremap <C-f><C-f> :Files<CR>
nnoremap <C-f><C-g> :GitFiles<CR>
nnoremap <C-f><C-a> :Ag<CR>
nnoremap <C-f><C-b> :BLines <CR>

nmap <leader><tab> <plug>(fzf-maps-n)
let g:fzf_action = {
\ 'ctrl-t': 'tab split',
\ 'ctrl-x': 'split',
\ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '20%' }
" }}}
" Plugin: 'vim-fugitive' {{{
Plug 'tpope/vim-fugitive'           "Git integration
nnoremap <silent><Leader>gd :Gdiff <CR>
nnoremap <silent><Leader>st :Gstatus <CR>
nnoremap <silent><Leader>gp :Gpull<CR>
nnoremap <silent>gc :Gcommit %:p <CR>i
nnoremap <silent>ga :Gcommit %:p --amend <CR>jo*
" }}}
" {{{Plugin: 'neomake'
Plug 'benekastah/neomake'           "asynchronous :make
"Toggle neomake list
nnoremap <F12> :call ToggleNeomakeList()<CR>
let g:neomake_open_list = 0
let g:neomake_python_enabled_makers = ['pep8', 'flake8']
let g:neomake_tex_enabled_makers = ['lacheck', 'chktex']
let g:neomake_cpp_clang_maker = {
            \ 'args': ['-std=c++11'],
            \}
autocmd! BufWritePost * Neomake
" }}}
" Plugin: 'vim-repeat' {{{
Plug 'tpope/vim-repeat'          " .
"Settings for vim-repeat
" }}}
" Plugin: 'vimtex' {{{
Plug 'lervag/vimtex', {'for': 'latex' }          "A modern vim plugin for editing LaTeX
"Settings for vimtex
"Toggle comilation
nnoremap <silent> <F6> :call vimtex#latexmk#toggle()<CR>
"Errors
nnoremap <silent> <Leader>le :call vimtex#latexmk#errors()<CR>
"Lables
nnoremap <silent> <Leader>ll :call vimtex#labels#toggle()<CR>
"TOC
nnoremap <silent> <Leader>lt :call vimtex#toc#toggle()<CR>

let g:vimtex_view_general_viewer = 'evince'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_complete_recursive_bib = 1
let g:vimtex_complete_enabled = 1
autocmd FileType tex set foldmethod=expr
autocmd FileType tex set foldexpr=vimtex#fold#level(v:lnum)
autocmd FileType tex set foldtext=vimtex#fold#text()

" }}}
" Plugin: 'vim-commentary' {{{
Plug 'tpope/vim-commentary', {'on': '<Plug>Commentary'}          "comments
"Settings for vim-commentary
if !hasmapto('<Plug>Commentary') || maparg('gc','n') ==# ''
  xmap cc  <Plug>Commentary
  nmap cc  <Plug>Commentary
  omap cc  <Plug>Commentary
endif
"}}} "
call plug#end()
" }}} Plugins "
" General Settings {{{
"=== Misc Settings ===
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
" Wild menu and search {{{
set wildmenu
set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital
"set nohlsearch      " Noh after search
set gdefault        " when on, the :substitute flag 'g' is default on
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
"  Return to same line {{{
augroup line_return
au!
au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     execute 'normal! g`"zvzz' |
    \ endif
augroup END
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
" Follow the Leader
nnoremap <Leader>sp :setlocal spell! spelllang=en_us<CR>
nnoremap <Leader>r z=
nnoremap <Leader>w ]s
nnoremap <Leader>b [s
nnoremap <Leader>s :w <CR>
nnoremap <Leader>j gjzz
nnoremap <Leader>k gkzz
nnoremap <Leader>o qp
nnoremap <Leader>p @p
" Tabbing und buffering
nnoremap <Leader>tn :tabnew<space>
nnoremap <Leader>td :tabclose<CR>
nnoremap <Leader>bh :sbprevious<CR>
nnoremap <Leader>bl :sbnext<CR>
nnoremap <Leader>bd :bdelete<CR>
" Create splits with empty buffers in all directions
nnoremap <Leader>nh :leftabove  vnew<CR>
nnoremap <Leader>nl :rightbelow vnew<CR>
nnoremap <Leader>nk :leftabove  new<CR>
nnoremap <Leader>nj :rightbelow new<CR>
" For completion completion
inoremap <C-j> <C-N>
inoremap <C-k> <C-P>
nnoremap <Leader>del :call StripTrailingWhitespace()<CR>
"1}}}
" Resizing {{{
nnoremap <Leader>rh :vertical resize +10 <CR>
nnoremap <Leader>rl :vertical resize -10 <CR>
nnoremap <Leader>rj :resize +10 <CR>
nnoremap <Leader>rk :resize -10 <CR>
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
augroup VimReload
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
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
function StripTrailingWhitespace()
  if !&binary && &filetype != 'diff'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction
" }}} StripTrailingWhitespace "
colorscheme gruvbox
" vim: fdm=marker
