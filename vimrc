" Plugins {{{1 "
call plug#begin()
" Plugin: 'deoplete.nvim' {{{
Plug 'Shougo/deoplete.nvim'
let g:deoplete#enable_at_startup = 1
" }}} "
"{{{ Plugin: 'fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'
nnoremap <c-p> :FZF<CR>
nnoremap <c-b> :Buffers<CR>
nnoremap <silent><Leader>fl :BLines <cr>
nnoremap <silent><Leader>ft :Tags <cr>
nnoremap <silent><Leader>fm :Maps<cr>
nmap <leader><tab> <plug>(fzf-maps-n)
let g:fzf_action = {
\ 'ctrl-t': 'tab split',
\ 'ctrl-x': 'split',
\ 'ctrl-v': 'vsplit' }
"}}}
"{{{Plugin: 'lightline.vim'
Plug 'itchyny/lightline.vim'        "Neat information line
set laststatus=2
set statusline+=%#warningmsg#
set statusline+=%*
let g:lightline = {
\ 'colorscheme': 'gruvbox',
\ }
"}}}
"{{{Plugin: 'gruvbox'
Plug 'morhetz/gruvbox'              "Colorscheme
set t_Co=256
set background=dark
"}}}
"{{{Plugin: 'neomake'
Plug 'benekastah/neomake'           "asynchronous :make
nnoremap <silent><Leader>m :let g:neomake_open_list = 0<CR> :Neomake <CR>
nnoremap <silent><Leader>ml :let g:neomake_open_list = 1<CR> :Neomake <CR>
let g:neomake_open_list = 0
let g:neomake_python_enabled_makers = ['pep8', 'pylint']
"}}}
" Plugin: 'nerdcommenter' {{{
Plug 'scrooloose/nerdcommenter'          "Commenter
"Settings for nerdcommenter

"}}} "
" Plugin: 'nerdtree' {{{
Plug 'scrooloose/nerdtree'          "Fileexplorer
nnoremap <silent><F1> :NERDTreeToggle <CR>
" }}} "
" Plugin: 'vim-expand-region' {{{2
Plug 'terryma/vim-expand-region'    "Expand visual region v/<c-v>
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
" }}} "
" Plugin: 'vim-fugitive' {{{
Plug 'tpope/vim-fugitive'           "Git integration
nnoremap <silent><Leader>gd :Gdiff <CR>
nnoremap <silent><Leader>st :Gstatus <CR>
nnoremap <silent><Leader>gp :Gpull<CR>
nnoremap <silent>cc :Gcommit %:p <CR>i
"}}} "
" Plugin: 'vim-buftabline' {{{
Plug 'ap/vim-buftabline'          "See current buffers
"Settings for vim-buftabline

"}}} "
" Plugin: 'vim-abolish' {{{
Plug 'tpope/vim-abolish'          "snake_case(crs) MixedCase(crm) camelCase(crc)
"Settings for vim-abolish

"}}} "
" Plugin: 'vim-repeat' {{{
Plug 'tpope/vim-repeat'          " .
"Settings for vim-repeat

"}}} "
" Plugin: 'vim-multiple-cursors' {{{
Plug 'terryma/vim-multiple-cursors'          "Multiple cursers
"Settings for vim-multiple-cursers

"}}} "
"{{{Plugin: 'vim-notes'
Plug 'xolox/vim-notes' | Plug 'xolox/vim-misc' " Vim notes
nnoremap <silent><F3> :RecentNotes <CR>
let g:notes_directories = ['~/Dropbox/notes']
let g:notes_suffix = '.txt'
let g:notes_word_boundaries = 1
" }}} "
"{{{Plugin: 'vim-sayonara'
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
nnoremap <silent> <BS> :Sayonara!<CR>
nnoremap <silent> <S-BS> :Sayonara<cr>
let g:sayonara_confirm_quit = 1
"}}}
" Plugin: 'vim-startify' {{{
Plug 'mhinz/vim-startify'           "Vim sessions
nnoremap <silent><F11> :Startify <CR>
let g:startify_session_dir = '~/.vim/session'
let g:startify_bookmarks = [
\ {'v': '~/git/dotfiles/init.vim'},
\ {'f': '~/git/dotfiles/config.fish'},
\ ]
let g:startify_list_order = [
\ ['   Bookmarks '], 'bookmarks',
\ ['   Files'],       'files' ,
\ ['   Sessions '],  'sessions',
\ ]

let g:startify_skiplist = [
\ 'COMMIT_EDITMSG',
\ ]
"}}}
" Plugin: 'vimtex' {{{
Plug 'lervag/vimtex'          "A modern vim plugin for editing LaTeX
"Settings for vimtex

"}}} "
" Plugin: 'supertab' {{{
Plug 'ervandew/supertab'            "Super tab
let g:SuperTabDefaultCompletionType = '<C-n>'
"}}}
" Plugin: 'ultisnips' {{{
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' 
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"}}}
" Plugin: 'undotree' {{{ "
Plug 'mbbill/undotree'              "A undo tree
nnoremap <silent><Leader>u :UndotreeToggle <CR><C-w>h
" }}} "
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
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let &t_SI = "\<Esc>[5 q"
let &t_SR = "\<Esc>[3 q"
let &t_EI = "\<Esc>[ q"
" }}}"
"{{{1 Key Mapping
let mapleader="\<Space>"
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
nnoremap <Leader>h :bprevious<CR>
nnoremap <Leader>l :bnext<CR>
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
