set runtimepath+=~/.vim


call plug#begin('~/.config/vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'rrethy/vim-hexokinase', {'do': 'make hexokinase'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" NERDTree:
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif
let NERDTreeShowHidden=0
highlight Directory ctermfg=white
nnoremap <silent> <expr> <C-t> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"


" Coc:
" disable Coc on *.sh files because of memory leak (~4Go RAM per file)
autocmd VimEnter *.sh exe "CocDisable"
set signcolumn=yes
function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction
inoremap <silent> <expr> <CR> coc#pum#visible() ? coc#pum#confirm()
    \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent> <expr> <Tab>
    \ coc#pum#visible() ? coc#pum#next(1) :
    \ CheckBackspace() ? "\<Tab>" :
    \ coc#refresh()
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"


" Hexokinase:
let g:Hexokinase_highlighters = [ 'foregroundfull' ]

let &t_8f="\e[38;2;%lu;%lu;%lum"
let &t_8b="\e[48;2;%lu;%lu;%lum"
set termguicolors

runtime! plugin/sensible.vim

filetype plugin indent on
autocmd Filetype make setlocal noexpandtab

set number
set cc=80
set autoindent
set backspace=indent,eol,start
set complete+=i

set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set title
set titlestring=%t
set history=500
set confirm
set background=dark
set mouse=a
set visualbell
set nowrap
set cursorline
set hlsearch
set incsearch
set ignorecase
set statusline=
set statusline+=\ %f
set statusline+=%=
set statusline+=\ %l:%c
set statusline+=\ \ \ [%3p%%]
set encoding=utf-8 fileencoding=
set nrformats-=octal
syntax on

set backup
set backupdir=~/.config/vim/backup
silent !mkdir ~/.config/vim/backup > /dev/null 2>&1
set dir=~/.config/vim/swap
silent !mkdir ~/.config/vim/swap > /dev/null 2>&1

colorscheme molokai_up

