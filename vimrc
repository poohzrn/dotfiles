let mapleader="\<Space>"
" Plugins {{{1 "
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
" Plugin: 'autopep8' {{{
Plug 'tell-k/vim-autopep8', {'for': 'python'}          "autopep8
"Settings for autopep
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
\ 'ctrl-s': 'split',
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
let g:neomake_error_sign = {
    \ 'texthl': 'ErrorMsg',
    \ }
let g:neomake_warning_sign = {
    \ 'texthl': 'WarningMsg',
    \ }
let g:neomake_open_list = 2
let g:neomake_python_enabled_makers = ['pylint']
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
Plug 'lervag/vimtex', {'for': 'tex' }          "A modern vim plugin for editing LaTeX
"Settings for vimtex
"Toggle comilation
nnoremap <silent> <F6> :call vimtex#latexmk#toggle()<CR>
"Errors
nnoremap <silent> <Leader>le :call vimtex#latexmk#errors()<CR>
"Lables
nnoremap <silent> <Leader>ll :call vimtex#labels#toggle()<CR>
"TOC
nnoremap <silent> <Leader>lt :call vimtex#toc#toggle()<CR>

let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_latexmk_progname = 'nvr'
" let g:vimtex_view_general_options_latexmk = '--unique'
" let g:vimtex_complete_recursive_bib = 1
" let g:vimtex_complete_enabled = 1
" autocmd FileType tex set foldmethod=expr
" autocmd FileType tex set foldexpr=vimtex#fold#level(v:lnum)
" autocmd FileType tex set foldtext=vimtex#fold#text()

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
" 1}}} "
" General Settings {{{ "
"=== Misc Settings ===
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
set switchbuf=usetab
set so=8            "8 lines to the curser
" }}} "
" Wild menu and search {{{ "
set wildmenu
set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital
set nohlsearch      " Noh after search
set gdefault        " when on, the :substitute flag 'g' is default on
"}}}
" Persistent Undo {{{ "
" Keep undo history across sessions, by storing in file.
if has('persistent_undo')
    if empty(glob('~/.vim/backups'))
        silent !mkdir ~/.vim/backups > /dev/null 2>&1 " takes a lot of time.. :<
    endif
set undodir=~/.vim/backups
set undofile
endif
"}}}
" Folding {{{ "
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
nnoremap zf zMzvzz
nnoremap zj zcjzvzz
nnoremap zk zckzvzz

" }}} "
"  Return to same line {{{ "
augroup line_return
au!
au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     execute 'normal! g`"zvzz' |
    \ endif
augroup END
" }}} "
" Cursor configuration {{{
" Use a blinking upright bar cursor in Insert mode, a solid block in normal
" and a blinking underline in replace mode
let &t_SI = "\<Esc>[5 q"
let &t_SR = "\<Esc>[3 q"
let &t_EI = "\<Esc>[ q"
" }}}"
"{{{1 Key Mapping
nnoremap <F2> :set invpaste paste?<CR>
nnoremap <F4> :e $MYVIMRC<CR>
nnoremap <F5> :so $MYVIMRC<CR>
nnoremap <F9> :!python %<CR>
nnoremap , :
nnoremap <space> <nop>
noremap <space><space> zz
nnoremap <c-j> <c-w>j
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-k> <c-w>k
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
" Resizing {{{ "
nnoremap <Leader>rh :vertical resize +10 <CR>
nnoremap <Leader>rl :vertical resize -10 <CR>
nnoremap <Leader>rj :resize +10 <CR>
nnoremap <Leader>rk :resize -10 <CR>
" }}} Resizing "
" Copy/Pase {{{ "
vnoremap yy "+y
vnoremap dd "+d
vnoremap pp "+p
vnoremap PP "+P
nnoremap pp "+p
nnoremap PP "+P
" }}} Copy/Pase "
" Mode: Command {{{ "
cnoremap <C-a> <Home>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-d> <Delete>
cnoremap <C-e> <End>
" }}} "
"1}}}
colorscheme gruvbox
" vim: fdm=marker
