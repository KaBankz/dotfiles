set number
set relativenumber
set autoindent
set tabstop=2
set shiftwidth=2
set smarttab
set softtabstop=2
set mouse=a
set cursorline
set termguicolors
"set cursorcolumn
set noshowmode
" Enable syntax highlighting
syntax enable
" Enable and load plugins and indents for current filetype
filetype plugin indent on

call plug#begin()

Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'blankname/vim-fish'
Plug 'dracula/vim'
" Plug 'crusoexia/vim-monokai'

call plug#end()

" Disable dracula background color, as it conflicts with terminal color
" scheme and created a jarring border
let g:dracula_colorterm=0
" Set theme to dracula
colorscheme dracula
"
" Set lightline colorscheme to dracula
let g:lightline={ 'colorscheme': 'dracula' }

"colorscheme monokai

"highlight Normal guibg=NONE ctermbg=NONE
"highlight clear LineNr
"highlight clear SignColumn

" Show hidden files/dirs by default in nerdtree
let NERDTreeShowHidden=1

" Set up :make to use fish for syntax checking.
autocmd FileType fish compiler fish
" Set this to have long lines wrap inside comments.
autocmd FileType fish setlocal textwidth=79
" Enable folding of block structures in fish.
autocmd FileType fish setlocal foldmethod=expr
