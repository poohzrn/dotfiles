let g:mapleader="\<Space>"
" Plugins {{{ "
call plug#begin()
" colorschemes {{{ "
Plug 'danilo-augusto/vim-afterglow'
Plug 'altercation/vim-colors-solarized'
Plug 'alessandroyorba/despacio'
" }}} colorschemes "
" python {{{
Plug 'davidhalter/jedi', {'for': 'python'}
Plug 'zchee/deoplete-jedi', {'for': 'python'}
Plug 'tell-k/vim-autopep8', {'for': 'python'}
" Plugin: 'ale' {{{
Plug 'w0rp/ale',  {'for': 'python'}
let g:ale_python_pylint_executable = 'python3'
let g:ale_python_pylint_options = '-rcfile $HOME/.pylintrc'
"}}} "
" Plugin: 'python_fold' {{{
Plug 'vim-scripts/python_fold'

"}}} "
let g:autopep8_disable_show_diff=1
let g:python_host_prog  = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'
" }}} python
" Plugin: 'ultisnips' {{{
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
" }}}
" Plugin: 'deoplete.nvim' {{{
Plug 'Shougo/deoplete.nvim'
set runtimepath+=~/.config/nvim/bundle/deoplete.nvim/
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
" }}}
" Plugin: 'vim-fugitive' {{{
Plug 'tpope/vim-fugitive'
"}}} "
" Plugin: 'FZF' {{{
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'
nnoremap <C-f><C-f> :Files<CR>
nnoremap <C-f><C-g> :GitFiles<CR>
nnoremap <C-f><C-a> :Ag<CR>
let g:fzf_layout = { 'down': '25%' }
"}}} "
" Plugin: 'vim-commentary' {{{
Plug 'tpope/vim-commentary', {'on': '<Plug>Commentary'}          "comments
if !hasmapto('<Plug>Commentary') || maparg('gc','n') ==# ''
    xmap cc  <Plug>Commentary
    nmap cc  <Plug>Commentary
    omap cc  <Plug>Commentary
endif
"}}} "
"{{{ Plugin: 'neomake'
Plug 'neomake/neomake', {'for': 'tex'}
let g:neomake_open_list = 0
let g:neomake_tex_enabled_makers = ['chktex', 'lacheck', 'proselint']
augroup NEOMAKE
    autocmd! BufWritePost *.tex Neomake
augroup end
" }}}
"{{{ Plugin: 'vimtex'
Plug 'lervag/vimtex', {'for': 'tex'}
augroup SET_TEX
      autocmd BufRead,BufNewFile *.tex set ft=tex
      autocmd BufRead,BufNewFile *.tex set spell spelllang=en_us
      autocmd BufRead,BufNewFile *.tex setlocal formatoptions-=a
      autocmd FileType tex let b:vimtex_main = 'master.tex'
      autocmd BufRead,BufNewFile *.tex let g:tex_flavor = 'latex'
      set foldtext=vimtex#fold#text()
      let g:vimtex_fold_enabled = 1
      let g:vimtex_quickfix_autojump = 1
      let g:vimtex_quickfix_mode = 2
augroup end
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
" UI {{{ "
" Plugin: 'vim-airline' {{{
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
let g:airline_mode_map = {'n': 'N', 'i' : 'I', 'R': 'R', 'v': 'V', 'V': 'V'}
if !exists('g:airline_symbols') | let g:airline_symbols = {} | endif
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep = '|'
let g:airline_right_alt_sep = '|'
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = ''
"}}} "
" }}} UI "
call plug#end()
" }}} Plugins "
" General Settings {{{
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
set diffopt+=vertical
set path+=**
set smarttab
filetype plugin indent on
set noswapfile      "disable .swp files
set nobackup        "disable .swp files
set nowritebackup "disable .swp files
syntax enable       "enable syntax highlighting
syntax on
set list listchars=tab:\ \ ,trail:·     "Display tabs and trailing spaces visually
set number          "show line numbers
set tabstop=4       "set tabs to have 4 spaces
set autoindent      "indent when moving to the next line while writing code
set expandtab       "expand tabs into spaces
set shiftwidth=4    "when using the >> or << commands, shift lines by 4 spaces
set cursorline      "show a visual line under the cursor's current line
set showmatch
set runtimepath+=~/.fzf/
set scrolloff=8            "8 lines to the curser
set autowriteall             "Write the contents of the file, auto
if v:version > 703 || v:version == 703 && has('patch541')
    set formatoptions+=j " Delete comment character when joining commented lines
endif
if exists('&inccommand')
    set inccommand=split
    nnoremap <C-s> :%s:
endif
" General Settings}}}
" Fold {{{
nmap <tab> za
nnoremap zf zMzvzz
nnoremap zj zcjzvzz
nnoremap zk zckzvzz
if &foldmethod ==# ''
    set foldmethod=syntax
endif
set foldlevel=0
set foldcolumn=0
set foldlevelstart=2
set foldtext=TxtFoldText()
function! TxtFoldText()
    let l:level = repeat('-', min([v:foldlevel-1,3])) . '+'
    let l:title = substitute(getline(v:foldstart), '{\{3}\d\?\s*', '', '')
    let l:title = substitute(l:title, '^["#! ]\+', '', '')
    return printf('%-4s %-s', l:level, l:title)
endfunction
" }}} Fold
" Netrw {{{ "
noremap <F1> :Lexplore<cr>
"
augroup netrw_close
    autocmd!
    autocmd filetype netrw call NetrwClose()
augroup END
function! NetrwClose()
    noremap <buffer> <F1> :bd<cr>
endfunction
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
" }}} Netrw "
" Wild menu and search {{{
set wildmenu
set wildignore+=tags,*.pyc,*.aux,*.dvi,*.log,*.toc,*.bbl,*.blg,*.gz,*.out,*.thm,*.ps,*.idx,*.ilg,*.ind,*.fdb_latexmk,*.tdo,*.fls,*.lox,*.ist,*.pdf
set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital
set gdefault        " when on, the :substitute flag 'g' is default on
set relativenumber  " Relative line numbers
nmap <silent> hs :set hlsearch!<CR>
" }}}
" {{{1 Key Mapping
nnoremap <silent> <F2> :set invpaste paste?<CR>
noremap <space><space> zz
nnoremap <C-j> <c-w>j
nnoremap <C-h> <c-w>h
nnoremap <C-l> <c-w>l
nnoremap <C-k> <c-w>k
inoremap <CR>f <esc>
nnoremap <BS> <C-^>
nnoremap <leader>sp :setlocal spell! spelllang=en_us<CR>
nnoremap <leader>spda :setlocal spell! spelllang=da<CR>
nnoremap <leader>j gjzz
nnoremap <leader>k gkzz
" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
"1}}}
" Persistent Undo {{{
" Keep undo history across sessions, by storing in file.
if has('persistent_undo')
    silent !mkdir -p ~/.vim/backups
    set undodir=~/.vim/backups
    set undofile
endif
" }}}
" Cursor configuration {{{
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let &t_SI = "\<Esc>[5 q"
let &t_SR = "\<Esc>[3 q"
let &t_EI = "\<Esc>[ q"
" }}}"
" Copy/Paste {{{
vnoremap yy "+y
vnoremap dd "+d
vnoremap pp "+p
vnoremap PP "+P
nnoremap pp "+p
nnoremap PP "+P
" }}} Copy/Pase "
" Line Return {{{
augroup line_return
    au!
    au BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \     execute 'normal! g`"zvzz' |
                \ endif
augroup END
" }}} Line Return
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
" Mode: Command {{{
cnoremap <C-a> <Home>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-d> <Delete>
cnoremap <C-e> <End>
cnoremap W w
" }}}
" FixWord {{{ "
" Neat for tpyos
function! FixWord() abort
    if &spell
        normal! 1z=
    endif
endfunction
command! FixWord :call FixWord()
nnoremap <CR><CR> :FixWord<CR>
" }}} FixWord "
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
" GetRunningOS {{{ "
function! GetRunningOS()
  if has("win32")
    return "win"
  endif
  if has("unix")
    if system('uname')=~'Darwin'
      return "mac"
    else
      return "linux"
    endif
  endif
endfunction
" }}} GetRunningOS "
" os x {{{ "
if GetRunningOS() == 'mac'
    set clipboard=unnamed
    let g:python_host_prog = "/usr/local/bin/python"
    let g:python3_host_prog = "/usr/local/bin/python3"
endif
" }}} os x "
syntax enable
colorscheme afterglow
" vim: fdm=marker
