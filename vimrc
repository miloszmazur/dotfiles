execute pathogen#infect()
let mapleader = ","
set nocompatible
filetype plugin indent on
syntax on
set bg=dark    " Setting dark mode
"imap <esc> :noh<return><esc>
set number
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
set showfulltag
set tabstop=4
set scrolloff=8
set expandtab
set t_Co=256
set clipboard+=unnamed
set listchars=tab:▸\ ,trail:•,extends:❯,precedes:❮
set showbreak=↪\

" colorschemes!
" colorscheme gruvbox
" colorscheme solarized
" colorscheme spacegray
colorscheme badwolf
let g:solarized_termtran=1

" CtrlP
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|output|bower_components|dist)|(\.(swp|hg|git|svn))$'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_switch_buffer = 0

" indent faster, with single '>' and '<'
nmap > >>
nmap < <<

imap jk <Esc>
" remove search hightlights
nmap <silent> ,h :nohls<CR>
autocmd Filetype gitcommit setlocal spell textwidth=72  " set columns to 72 on git commits
" toggle NerdTree with ctrl + n
map <C-n> :NERDTreeToggle<CR>
" quit vim if NerdTree is the only buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nnoremap <leader>r :!%:p " run fies with a shebang with <leader> r
" open a new vertical split window with <leader> w
nnoremap <leader>w <C-w>v<C-w>l

" move between splits faster - with ctrl + direction
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" make vim open splits on right and bottom
set splitbelow
set splitright

autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#enable_auto_select = 0
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    " return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

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
