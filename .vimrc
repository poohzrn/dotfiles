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
colo molokai
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
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" Rescue Time
set title
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)
"
" YMCA
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<c-n>'
" Key bindings
set pastetoggle=<F2>
nnoremap <F2> :set invpaste paste?<CR>
nnoremap , :
nnoremap ½ $
nnoremap <space> <NOP>
nnoremap n nzzzv

noremap <space><space> <PageDown>zz
noremap <BS> <PageUp>zz
noremap j jzz
noremap k kzz
noremap q :q<CR>
"
" bindnings for tabbing und buffering
noremap tl :tabnext<CR>
noremap th :tabprev<CR>
noremap tn :tabnew<space>
noremap tc :tabclose<CR>
noremap bh :bprevious<CR>
noremap bl :bnext<CR>
noremap bd :bdelete<CR>
"
noremap sp :setlocal spell! spelllang=en_us<CR>
noremap sy :SyntasticToggleMode <CR>
noremap cc :Gcommit % <CR>i
noremap gd :Gdiff <CR>
noremap st :Gstatus <CR>

let mapleader="\<Space>"
nnoremap <Leader>r z=
nnoremap <Leader>w ]s
nnoremap <Leader>b [s
nnoremap <Leader>s :w <CR>
nnoremap <Leader>m :Latexmk<CR>
nnoremap <Leader>t :TagbarToggle<CR>
nnoremap <Leader>j gjzz
nnoremap <Leader>k gkzz
nnoremap <Leader>c :Gcommit % <CR>i
nnoremap <Leader>d :Gdiff <CR>
nnoremap <Leader>st :Gstatus <CR>

nnoremap <Leader>h :bprevious<CR>
nnoremap <Leader>l :bnext<CR>
