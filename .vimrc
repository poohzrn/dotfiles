execute pathogen#infect()
autocmd BufNewFile,BufRead *.tex set spell
filetype plugin indent on
" disable .swp files
set noswapfile
set nobackup
set nowb
let g:tex_flavor='latex'
" enable syntax highlighting
syntax enable
syntax on
let python_highlight_all = 1
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
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"
" Trigger configuration. 
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" Rescue Time
set title
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)
"" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
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
set pastetoggle=<F2>
nnoremap <F2> :set invpaste paste?<CR>
nnoremap <F9> :!python %<CR>
nnoremap , :
nnoremap ½ $
vnoremap ½ $
nnoremap <space> <NOP>
noremap <space><space> zz
noremap xx :x<CR>
noremap qq :q<CR>

" Commit amazingly super FaZssT
noremap cc :Gcommit %:p <CR>i

"Follow the Leader
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
" Tabbing und buffering
noremap <Leader>tl :tabnext<CR>
noremap <Leader>th :tabprev<CR>
noremap <Leader>tn :tabnew<space>
noremap <Leader>tc :tabclose<CR>
noremap <Leader>bh :bprevious<CR>
noremap <Leader>bl :bnext<CR>
noremap <Leader>bd :bdelete<CR>
" LOS COMANDOS MODE
cnoremap , :
cnoremap <C-a> <Home>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-d> <Delete>
cnoremap <C-e> <End>
