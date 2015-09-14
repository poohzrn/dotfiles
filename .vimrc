" set spelllang=en_gb spell
autocmd BufNewFile,BufRead *.tex set spell
execute pathogen#infect()
syntax on
filetype plugin indent on

" enable syntax highlighting
syntax enable

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

" enable all Python syntax highlighting features
let python_highlight_all = 1

" enable Air-Line
set laststatus=2
let g:airline_theme='simple'
" enable 256 colors
set t_Co=256
colo molokai
" enable wild menu
set wildmenu
