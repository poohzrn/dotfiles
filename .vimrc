
"" ================ Plugins ==================

call plug#begin('~/.vim/plugged')
    "Lean & mean status/tabline for vim that's light as air.
    Plug 'bling/vim-airline'
    " A git wrapper
    Plug 'tpope/vim-fugitive'
    " Code completeon engine for Vim
    Plug 'Valloric/YouCompleteMe'
    " Colorscheme
    Plug 'tomasr/molokai'
    " Latex tool box
    Plug 'LaTeX-Box-Team/LaTeX-Box'
    " Vim-snippets depends on ultisnips
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
    Plug 'ervandew/supertab'
    Plug 'majutsushi/tagbar'
    Plug 'bling/vim-bufferline'
    Plug 'scrooloose/syntastic'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'laurentgoudet/vim-howdoi'
    Plug 'mbbill/undotree'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
call plug#end()
"TODO

filetype plugin indent on
" disable .swp files
set noswapfile
set nobackup
set nowb
" enable syntax highlighting
syntax enable
syntax on
" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·
" show line numbers
set number
" set tabs to have 4 spaces
set ts=4
" indent when moving to the next line while writing code
set autoindent
" expand tabs into spaces
set expandtab
" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4
" show a visual line under the cursor's current line 
set cursorline
" show the matching part of the pair for [] {} and ()
set showmatch
" enable Air-Line
set laststatus=2
let g:airline_theme='simple'
" enable 256 colors
set t_Co=256
let g:molokai_original = 1
let g:rehash256 = 1
let python_highlight_all = 1
let g:tex_flavor='latex'
colorscheme molokai
" enable wild menu
set wildmenu
set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital
set nohlsearch      " Noh after search
" Fantastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
"let g:syntastic_mode_map = { 'passive_filetypes': ['tex'] }
let g:syntastic_check_on_wq = 0
"
" Trigger configuration. 
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

set pastetoggle=<F2>
set rtp+=/home/lasse/.fzf
"
"" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

"
" YMCA
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
" Key bindings
nnoremap <F2> :set invpaste paste?<CR>
nnoremap <F9> :!python %<CR>
nnoremap , :
nnoremap ½ $
vnoremap ½ $
nnoremap <space> <NOP>
"
"Use FZF (Fazt Zearch Fandme)
nnoremap <C-t> :FZF<CR>
nnoremap <C-b> :Buffers<CR>
noremap <space><space> zz
" Handy shortcuts
" save and close
noremap xx :x<CR>

" Commit amazingly super FaZssT
noremap cc :Gcommit %:p <CR>i

"
" Follow the Leader
let mapleader="\<Space>"
nnoremap <Leader>sp :setlocal spell! spelllang=en_us<CR>
nnoremap <Leader>sy :SyntasticToggleMode <CR>
nnoremap <Leader>u :UndotreeToggle<CR><C-w>h
nnoremap <Leader>gd :Gdiff <CR>
nnoremap <Leader>st :Gstatus <CR>
nnoremap <Leader>r z=
nnoremap <Leader>w ]s
nnoremap <Leader>b [s
nnoremap <Leader>s :w <CR>
nnoremap <Leader>m :Latexmk<CR>
nnoremap <Leader>t :TagbarToggle<CR>
nnoremap <Leader>j gjzz
nnoremap <Leader>k gkzz
nnoremap <Leader>h :bprevious<CR>
nnoremap <Leader>l :bnext<CR>
nnoremap <Leader>o qp
nnoremap <Leader>p @p
"
" Tabbing und buffering
noremap <Leader>tl :tabnext<CR>
noremap <Leader>th :tabprev<CR>
noremap <Leader>tn :tabnew<space>
noremap <Leader>td :tabclose<CR>
noremap <Leader>bh :bprevious<CR>
noremap <Leader>bl :bnext<CR>
noremap <Leader>bd :bdelete<CR>
"
" LOS COMANDOS MODE
cnoremap , :
cnoremap <C-a> <Home>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-d> <Delete>
cnoremap <C-e> <End>
