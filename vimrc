execute pathogen#infect() 
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
colorscheme solarized

" ctrlP stuff, stolen from Konrad Wasowicz
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|output|bower_components|dist)|(\.(swp|hg|git|svn))$'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" indent faster, with single '>' and '<'
nmap > >>
nmap < <<
imap jk <Esc>
