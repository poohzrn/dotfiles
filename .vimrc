" set spelllang=en_gb spell
execute pathogen#infect()
autocmd BufNewFile,BufRead *.tex set spell
filetype plugin indent on
syntax on
" disable .swp files
set noswapfile
set nobackup
set nowb
let g:tex_flavor='latex'
nnoremap <F11> :Latexmk<CR>
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
" bind , to :
nnoremap , :
" Trigger configuration. 
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<c-n>'
" Tagbar mapping:
nmap <F12> :TagbarToggle<CR>
" Buffers
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprevious<CR>
" Git
nnoremap <C-o> :Gcommit . <CR>i
