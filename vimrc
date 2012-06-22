" Author:  Egor Gumenyuk (boo1ean0807 at gmail dot com)
" Updated: Sun Mar 11 14:30:21 UTC 2012


" Set some system defaults
runtime! debian.vim

" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" Set default encoding
set fileencodings=utf8,cp1251
set encoding=utf8

" Init pathogen
filetype off
call pathogen#infect('$HOME/.vim/bundle')
filetype plugin indent on

" Disable some gui elements
set guioptions-=m
set guioptions-=T
set guioptions-=l
set guioptions-=r
set guioptions-=b

" Enable filetype plugins and disable vi compatibility
set nocompatible
filetype on
filetype plugin on

" Show info in the window title
set title

" Number of screen lines to show around the cursor
set scrolloff=3

" Keep long history
set history=1000

" By default disable hlsearch
set nohlsearch

" Use manual foldmethod
set foldmethod=manual

" Disable swap files
set noswapfile

" Disable beackup files
set nobackup

" Hide mouse while typing
set mousehide

" Show match for partly typed search command
set incsearch

" Command-line completion shows a list of matches
set wildmenu

" Ignore case when using a search pattern
set ignorecase

" Show b matches
set showmatch

" Enable syntax and line numbering
syntax on
set number

" Smartcase for search queries
set smartcase

" Enable ruler on bottom-right corner
set ruler

" Enable indention
set autoindent
set copyindent
set smartindent

" Enable color line to prevent long lines
set colorcolumn=85

" Set tabstop end expad tabs to spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Hide tabline
set showtabline=0

" Enable undo history between sessions
set undofile
set undodir=~/.vim/undodir
set undolevels=1000
set undoreload=10000

" Show incomplete command on footer
set showcmd

" Save session by specified key
function SaveSession(key)
  wa!
  execute 'mksession! $HOME/.vim/s_'.a:key.'.vim'
endfunction
command -nargs=+ SS call SaveSession(<f-args>)

" Load session by specified key
function LoadSession(key)
  execute 'source $HOME/.vim/s_'.a:key.'.vim'
  only
  MiniBufExplorer
endfunction
command -nargs=+ LS call LoadSession(<f-args>)

" Sudo to write
cmap sudow w !sudo tee % >/dev/null


" Disable arrow keys
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>

" For normal navigation on breaked lines
nnoremap j gj
nnoremap k gk

" Go to next buffer (minibufexplorer)
nnoremap gt :MBEbn<cr>

" Custom whitespaces and tabs view
set list
set listchars=trail:·,tab:⟶\ 

" Set leader button
let mapleader = ","

" For faster scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Just press ESC
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Toggle NERDTree
noremap  <silent> <leader>f :NERDTreeToggle<cr>

" Next matching from Qickfix list
noremap  <silent> <leader>n :cn<cr>

" Prev matching from Qickfix list
noremap  <silent> <leader>p :cp<cr>

" Next matching tag match
noremap  <silent> <leader>b :tnext<cr>

" Prev matching tag match
noremap  <silent> <leader>B :tprevious<cr>

" Grep current word and open QuickFix window
noremap  <leader>g :execute 'vimgrep /'.expand('<cword>').'/ **'<cr>:cw<cr><C-w>t<C-w>j

" Switch between header and cpp
noremap gh :A<cr>

" Copy\paste through clipboard
noremap  <silent> <leader>y "+y
noremap  <silent> <leader>p "+p

" Add current file to staging area(fugitive)
noremap  <silent> <leader>a :Git add %<cr>

" Ultra exit
noremap  <silent> <leader>q :qa!<cr>

" Toggle gundo
noremap  <silent> <leader>u :GundoToggle<cr>

" Align blocks separated by ':'
vnoremap  <silent> <leader>t :Tabularize /:<cr>

" Toggle hlsearch on space
nnoremap <silent> <Space> :set hlsearch! hlsearch?<cr>

let g:miniBufExplModSelTarget = 1
let g:miniBufExplMapWindowNavVim = 1

" Autoclose preview window(c.vim)
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif


" Set 256 color terminal
set t_Co=256

" Use custom color scheme
colorscheme wombat256
