" Set leader button before plugins to allow bindings
let mapleader = ","

" Key bindings
"
" <leader>-u        open undotree
" <leader>-s        strip all trailing whitespaces in file
" <leader>-m        show list of recently used files
" <leader>-f        toggle NERDTree (fs tree)
" <leader>-c-space  comments toggle
" <leader>-q        quit without saving
" space             toggle hilight on search results
" <Shift>+l         switch switch next buffer
" <Shift>+h         switch to previous buffer


"
 "PLUGINS SECTION
" Each plugin is followed custom configuration and bindings immediately on the next lines if necessary
"
call plug#begin(stdpath('data') . '/plugged')

" Visualize undotree with navigation
Plug 'mbbill/undotree'
let g:undotree_SetFocusWhenToggle = 1
noremap <silent> <leader>u :UndotreeToggle<cr>

" Return to the recent active position on file open
Plug 'vim-scripts/lastpos.vim'

" Highligh trailing whitespaces and provide strip util
Plug 'ntpeters/vim-better-whitespace'
let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm=0
let g:show_spaces_that_precede_tabs=1
noremap <silent> <leader>s :StripWhitespace<cr>

" Show recent used files
Plug 'vim-scripts/mru.vim'
noremap <silent> <leader>m :Mru<cr>

" Fancy statusline replacement + topbar buffers pannel
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='distinguished'

" File system tree navigation
Plug 'scrooloose/nerdtree'
noremap  <silent> <leader>f :NERDTreeToggle<cr>

" Comments utilities
Plug 'scrooloose/nerdcommenter'

" Code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Vue syntax stuff + hack for nerd commenter to work properly
Plug 'posva/vim-vue'
let g:vue_pre_processors = ['pug', 'scss']
let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction

" Fuzzy files search also isntalled to the system
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Allows repeat `.` operations for vim-surround plugin
Plug 'tpope/vim-repeat'

" Surround anything with quotes and other surrounding pairs
Plug 'tpope/vim-surround'

" Render colors in css
Plug 'ap/vim-css-color'

" Allow % navigation for html tags, if-else and so on
Plug 'andymass/vim-matchup'

call plug#end()

"
" BASIC SETTINGS
"

" Set tab and indent size
set tabstop=4
set shiftwidth=4

" Enable syntax and line numbering
syntax on
set number

" This sets the minimum window height to N
set wmh=0

" Ignore case when using a search pattern
set ignorecase

" Show match for partly typed search command
set incsearch

" Hide mouse while typing
set mousehide

" Disable swap files
set noswapfile

" Disable beackup files
set nobackup

" By default disable hlsearch
set nohlsearch

" Keep long commands history
set history=1000

" Number of screen lines to show around the cursor
set scrolloff=3

" Show info in the window title
set title

" Always show the statusline
set laststatus=2

" Restore normal backspace behaviour
set backspace=indent,eol,start

" Automatically reload changes if detected
set autoread

" Command-line completion shows a list of matches
set wildmenu

" Enable indention
set autoindent
set copyindent
set smartindent

" Use system clipboard
set clipboard+=unnamedplus

" Enable undo history between sessions
set undofile
set undodir=~/.config/nvim/undodir
set undolevels=1000
set undoreload=10000

" Enable ruler on bottom-right corner
set ruler

" Fix typos on wq
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev WQ wq

"
" REMAP
"

" For normal navigation on breaked lines
nnoremap j gj
nnoremap k gk

" Disable arrow keys
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>

" Just press ESC
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Windows (splits) navigation
nnoremap <silent> <C-h> :wincmd h<cr>
nnoremap <silent> <C-j> :wincmd j<cr>
nnoremap <silent> <C-k> :wincmd k<cr>
nnoremap <silent> <C-l> :wincmd l<cr>

" Buffers navigation
nnoremap <silent> <S-h> :bprev<cr>
nnoremap <silent> <S-l> :bnext<cr>
nnoremap <silent> <leader>d :bdelete<cr>

" Ultra exit
noremap <silent> <leader>q :qa!<cr>

" Toggle hlsearch on space
nnoremap <silent> <Space> :set hlsearch! hlsearch?<cr>

" Set 256 color terminal and colorscheme
set t_Co=256
colorscheme wombat256
