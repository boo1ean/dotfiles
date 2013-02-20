" Author:  boo1ean0807 at gmail dot com
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

" Init Vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" snipmate deps
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/snipmate-snippets"
Bundle "mattn/webapi-vim"
Bundle "mattn/gist-vim"

Bundle "kchmck/vim-coffee-script"
Bundle "pangloss/vim-javascript"
Bundle "tpope/vim-repeat"
Bundle "vim-scripts/mru.vim"

Bundle "lepture/vim-css"

Bundle "joonty/vdebug"
Bundle "godlygeek/tabular"
Bundle "Shougo/neocomplcache"
Bundle "scrooloose/syntastic"
Bundle 'Lokaltog/vim-powerline'
Bundle "garbas/vim-snipmate"
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup'
Bundle 'tpope/vim-fugitive'
Bundle 'matchit.zip'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/nerdcommenter'
Bundle 'lastpos.vim'
Bundle 'ctrlp.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'jQuery'
Bundle 'scrooloose/nerdtree'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'svndiff.vim'

filetype plugin indent on

" Disable some gui elements
set guioptions-=m
set guioptions-=T
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=b

" Enable filetype plugins and disable vi compatibility
set nocompatible
filetype on
filetype plugin on

" Dash isn't word separator
set iskeyword+=-

" Use global clipboard
set clipboard+=unnamed

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
"cmap w!! w !sudo tee % >/dev/null


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
set listchars=trail:·,tab:··

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
noremap  <silent> <leader>b :cn<cr>

" Prev matching from Qickfix list
noremap  <silent> <leader>B :cp<cr>

" Next matching tag match
noremap  <silent> <leader>n :tnext<cr>

" Prev matching tag match
noremap  <silent> <leader>N :tprevious<cr>

" Grep current word and open QuickFix window
"noremap  <leader>g :execute 'vimgrep /'.expand('<cword>').'/ **'<cr>:cw<cr><C-w>t<C-w>j

" Execute FuzzyFinder dir search
noremap  <leader>g :FufDir<cr>

" Switch between header and cpp
noremap gh :A<cr>

" Copy\paste through clipboard
noremap <silent> <leader>y "+y
noremap <silent> <leader>p "+p

" Add current file to staging area(fugitive)
noremap <silent> <leader>a :Git add %<cr>

" Ultra exit
noremap <silent> <leader>q :qa!<cr>

" Toggle gundo
noremap <silent> <leader>u :GundoToggle<cr>

" Align blocks separated by =>
vnoremap <silent> <leader>t :Tabularize /=><cr>

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
    \ 'scheme' : $HOME.'/.gosh_completions'
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

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif

let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" Detect filetype for gist from the filename
let g:gist_detect_filetype = 1
" Show privates gists within Gist -l
let g:gist_show_privates = 1

" Set 256 color terminal
set t_Co=256

" Use custom color scheme
colorscheme wombat256
