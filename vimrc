execute pathogen#infect()
filetype plugin indent on
let mapleader = ","
nnoremap Y y$
set nocompatible
set noshowmode
set mouse=a
syntax on
set term=screen-256color
"imap <esc> :noh<return><esc>
set number
set relativenumber
set hidden
set backspace=indent,eol,start
set hls is " highlight matches and start search while typing
set showcmd " show incomplete commands in the status bar
set history=100
set autoindent "indents using whitespaces
set laststatus=2 " make file status etc. always visible
set smartindent
set ignorecase
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set scrolloff=8
set expandtab
set t_Co=256
set clipboard+=unnamed
set listchars=tab:▸\ ,trail:•,extends:❯,precedes:❮
set showbreak=↪\
set tags=./tags
set splitbelow " make vim open splits on right and bottom
set splitright " make vim open splits on right and bottom

" use rg for grepping
set grepprg=rg\ --vimgrep\ --fixed-strings

"use fzf as
set rtp+=/usr/local/opt/fzf
nnoremap <c-p> :Files<CR>
nnoremap <leader>t :Tags<CR>

" colorschemes!
set bg=dark
colorscheme gruvbox
" colorscheme spacegray
" colorscheme badwolf

nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
nnoremap j gj
nnoremap k gk

nnoremap <leader>> <C-W>>
nnoremap <leader>< <C-W><

"remove hanging whitespace
nnoremap <leader>s :%s/\s\+$//e<CR>

" open a new vertical split window with <leader> w
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>v :vnew<CR>

" move between splits faster - with ctrl + direction
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


"nerdTREE
" toggle NerdTree with ctrl + n
map <C-n> :NERDTreeToggle<CR>
" quit vim if NerdTree is the only buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Syntastic!
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['pycodestyle', 'pyflakes']
let g:syntastic_rst_checkers = ['sphinx']
let g:syntastic_python_pycodestyle_args = "--max-line-length=100 --ignore=E731,E402"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_quiet_messages = { "type" : "style" }

function! ToggleStyleMessages()
    if exists("g:syntastic_quiet_messages")
        unlet g:syntastic_quiet_messages
    else
        let g:syntastic_quiet_messages = { "type" : "style" }
    endif
endfunction
nmap <leader>ss :call ToggleStyleMessages()<CR>



" TeX Suite
let g:tex_flavor='latex'
let g:Tex_MultipleCompileFormats='dvi,pdf'

" GitGutter
let g:gitgutter_enabled = 0
let g:gitgutter_map_keys = 0
nnoremap <Leader>gg :GitGutterToggle<Cr>
nnoremap <Leader>gs :Gstatus<Cr>
nnoremap <Leader>gd :Gdiff<Cr>

autocmd Filetype gitcommit setlocal spell textwidth=72  " set columns to 72 on git commits


autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" Simple re-format for minified Javascript
command! UnMinify call UnMinify()
function! UnMinify()
    %s/{\ze[^\r\n]/{\r/g
    %s/){/) {/g
    %s/};\?\ze[^\r\n]/\0\r/g
    %s/;\ze[^\r\n]/;\r/g
    %s/[^\s]\zs[=&|]\+\ze[^\s]/ \0 /g
    normal ggVG=
endfunction

" commentary
autocmd FileType matlab setlocal commentstring=\%\ %s
