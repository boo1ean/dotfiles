" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.
"
" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif
"

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif



set fileencodings=utf8,cp1251
set encoding=utf8
set hls
set ic

" init pathogen
filetype off
call pathogen#infect()
filetype plugin indent on


"""""""""""""

set nocompatible
filetype on
filetype plugin on

set guioptions-=m
set guioptions-=T
set guioptions-=l
set guioptions-=r
set guioptions-=b

set title
set scrolloff=3
set history=1000
set nohlsearch
set foldmethod=manual
set noswapfile
set nobackup
set mousehide
set incsearch
syntax on
set number
set wildmenu
set ignorecase
set showmatch
set ttyfast

" Enable perl-regex at search
"nnoremap / /\v
"vnoremap / /\v

set smartcase
set ruler
set autoindent
set copyindent
set smartindent

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

set tabstop=2
set shiftwidth=2
set showtabline=0
set expandtab
set undofile
set undodir=~/.vim/undodir
set undolevels=1000
set undoreload=10000

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" Disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

set list
set listchars=trail:·,tab:⟶\ 
let mapleader = ","

nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Just press ESC
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

inoremap <S-k> <ESC>
nnoremap <S-k> <ESC>
vnoremap <S-k> <ESC>

" Toggle NERDTree
vnoremap <silent> <leader>f :NERDTreeToggle<cr>
noremap  <silent> <leader>f :NERDTreeToggle<cr>

" Next matching from Qickfix list
vnoremap <silent> <leader>n :cn<cr>
noremap  <silent> <leader>n :cn<cr>

" Prev matching from Qickfix list
vnoremap <silent> <leader>p :cp<cr>
noremap  <silent> <leader>p :cp<cr>

" Prev matching from Qickfix list
vnoremap <leader>g :execute 'vimgrep /'.expand('<cword>').'/ **'<cr>:cw<cr>5<C-w>k<C-w>j
noremap  <leader>g :execute 'vimgrep /'.expand('<cword>').'/ **'<cr>:cw<cr>5<C-w>k<C-w>j

" Inc window size
vnoremap <leader>r :res +1<cr>
noremap  <leader>r :res +1<cr>

" Dec window size
vnoremap <leader>R :res -1<cr>
noremap  <leader>R :res -1<cr>

" Show hidden files, too
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1

map  <silent> <F3> :Glog<cr>:cw<cr>
nmap  <silent> <F3> :Glog<cr>:cw<cr>
imap  <silent> <F3> <ESC>:Glog<cr>:cw<cr>

map   <silent> <F4> :TMiniBufExplorer<cr>
nmap  <silent> <F4> :TMiniBufExplorer<cr>
imap  <silent> <F4> <ESC>:TMiniBufExplorer<cr>

map   <silent> <F6> :w<cr> :mkview<cr>
nmap  <silent> <F6> :w<cr> :mkview<cr>
imap  <silent> <F6> <ESC>:w<cr> :mkview<cr>

map   <silent> <F7> :loadview<cr>
nmap  <silent> <F7> :loadview<cr>
imap  <silent> <F7> <ESC>:loadview<cr>

map   <silent> <leader>d :bdelete<cr>
nmap  <silent> <leader>d :bdelete<cr>

map   <silent> <leader>D :bdelete<cr>:bdelete<cr>
nmap  <silent> <leader>D :bdelete<cr>:bdelete<cr>

map   <silent> <leader>C :bdelete<cr>:bdelete<cr>:q!<cr>
nmap  <silent> <leader>C :bdelete<cr>:bdelete<cr>:q!<cr>

map   <silent> <leader>q :q!<cr>
nmap  <silent> <leader>q :q!<cr>

map   <silent> <leader>h :TlistHighlightTag<cr>
nmap  <silent> <leader>h :TlistHighlightTag<cr>

nnoremap <leader>v V`]

"toggle gundo
nmap    <silent> <leader>u :GundoToggle<cr>
vmap    <silent> <leader>u :GundoToggle<cr>
smap    <silent> <leader>u :GundoToggle<cr>
xmap    <silent> <leader>u :GundoToggle<cr>

"copy\paste through register Z
"nmap    <silent> <leader>y "zy
"vmap    <silent> <leader>y "zy
"smap    <silent> <leader>y "zy
"xmap    <silent> <leader>y "zy

"nmap    <silent> <leader>p "zp
"vmap    <silent> <leader>p "zp
"smap    <silent> <leader>p "zp
"xmap    <silent> <leader>p "zp

"copy\paste through clipboard
nmap    <silent> <leader>Y "+y
vmap    <silent> <leader>Y "+y
smap    <silent> <leader>Y "+y
xmap    <silent> <leader>Y "+y

nmap    <silent> <leader>P "+p
vmap    <silent> <leader>P "+p
smap    <silent> <leader>P "+p
xmap    <silent> <leader>P "+p

vmap  <silent> <leader>t :Tabularize /:<cr>

"toggle hlsearch on space
:nnoremap <silent> <Space> :set hlsearch! hlsearch?<cr>

"let Tlist_WinWidth=30
let Tlist_Auto_Highlight_Tage=1
let Tlist_Highlight_Tag_On_BufEnter=1
let Tlist_Use_Right_Window=1
let Tlist_Compact_Format=1
let Tlist_Inc_Winwidth=1


"let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplModSelTarget = 1 
let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplForceSyntaxEnable = 1

set t_Co=256
"set cursorline
colorscheme wombat256
"cs add ./cscope.out
"nmap <c-f> :cs find g <c-r>=expand("<cword>")<cr><cr>

"if getcwd() == "/home/boo1ean/buff_swabr"
  "nmap    <silent> <F7> :TlistSessionLoad ./tlist<cr>
  "nmap    <silent> <F8> :TlistSessionLoad ./tlistweb<cr>
  "nmap    <silent> <F5> :TlistToggle<cr>
"endif
