execute pathogen#infect() 
let mapleader = ","
set nocompatible
syntax on
set number
set backspace=indent,eol,start
set hls is " highlight matches and show even incomplete matches (?)
set showcmd " show even incomplete commands in the status bar
set history=100
filetype plugin indent on
" indents using whitespaces
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set bg=dark    " Setting dark mode 
set t_Co=256
set clipboard+=unnamed   " make the system's keyboard work with vim y, d, and P commands
"colorscheme gruvbox
" solarized things, uncomment to enable
let g:solarized_termtran=1
set background=dark
"colorscheme solarized
colorscheme spacegray
" ctrlP stuff, stolen from Konrad Wasowicz
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|output|bower_components|dist)|(\.(swp|hg|git|svn))$'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" indent faster, with single '>' and '<'
nmap > >>
nmap < <<
imap jk <Esc>
autocmd Filetype gitcommit setlocal spell textwidth=72  " set columns to 72 on git commits
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif " quit vim if NerdTree is the only buffer
nnoremap <leader>r :!%:p
nnoremap <leader>w <C-w>v<C-w>l  " open a new vertical split window with <leader> w
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
