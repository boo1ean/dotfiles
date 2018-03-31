" Author:  boo1ean0807 at gmail dot com
" Updated: Fri Mar 30 16:52:29 UTC 2018

" Set some system defaults
runtime! debian.vim

" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Set default encoding
set fileencodings=utf8,cp1251
set encoding=utf8

" Init Vundle
filetype off
set nocompatible
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'

Plugin 'ntpeters/vim-better-whitespace'
Plugin 'othree/html5.vim'
Plugin 'gorkunov/smartpairs.vim'
Plugin 'posva/vim-vue'
Plugin 'tpope/vim-repeat'
Plugin 'vim-scripts/mru.vim'
Plugin 'lepture/vim-css'
Plugin 'godlygeek/tabular'
Plugin 'Shougo/neocomplcache'
Plugin 'scrooloose/syntastic'
Plugin 'Lokaltog/vim-powerline'
Plugin 'rstacruz/sparkup'
Plugin 'tpope/vim-fugitive'
Plugin 'matchit.zip'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'
Plugin 'lastpos.vim'
Plugin 'ctrlp.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'scrooloose/nerdtree'
Plugin 'L9'

call vundle#end()

filetype plugin indent on

" Disable some gui elements
set guioptions-=m
set guioptions-=T
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=b

" use true color
set termguicolors

" Enable filetype plugins and disable vi compatibility
filetype on
filetype plugin on

" Dash isn't word separator
set iskeyword+=-

" Remove preview window
set completeopt-=preview

" Restore normal backspace behaviour
set backspace=indent,eol,start

" Use global clipboard
set clipboard+=unnamedplus

" Always show the statusline
set laststatus=2

" Automatically reload changes if detected
set autoread

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
set tabstop=4
set shiftwidth=4

" Hide tabline
set showtabline=0

" Enable undo history between sessions
set undofile
set undodir=~/.config/nvim/undodir
set undolevels=1000
set undoreload=10000

" Show incomplete command on footer
set showcmd

" Sudo to write
"cmap w!! w !sudo tee % >/dev/null

cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev WQ wq

" Windows navigation
nnoremap <silent> <C-h> :wincmd h<cr>
nnoremap <silent> <C-j> :wincmd j<cr>
nnoremap <silent> <C-k> :wincmd k<cr>
nnoremap <silent> <C-l> :wincmd l<cr>

" This sets the minimum window height to N
set wmh=0

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
nnoremap gt :bn<cr>

" Custom whitespaces and tabs view
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

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

" Show recent used files
noremap <silent> <leader>m :Mru<cr>

" Ultra exit
noremap <silent> <leader>q :qa!<cr>

" Toggle gundo
noremap <silent> <leader>u :GundoToggle<cr>

" Trim spaces from end of line
vnoremap <silent> <leader>s :s/\s\+$//<cr>

" Toggle hlsearch on space
nnoremap <silent> <Space> :set hlsearch! hlsearch?<cr>

let g:miniBufExplModSelTarget = 1
let g:miniBufExplMapWindowNavVim = 1

" Indent guides setup
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey

" Turn off auto working path feature (CtrlP)
let g:ctrlp_working_path_mode = ''

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

let g:jsx_ext_required = 0

" Detect filetype for gist from the filename
let g:gist_detect_filetype = 1
" Show privates gists within Gist -l
let g:gist_show_privates = 1

" Set 256 color terminal
set t_Co=256

" Use custom color scheme
colorscheme wombat256
