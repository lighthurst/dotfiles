" Minimal vimrc for remote servers (no plugins required)

" ============================================================
" Basic behavior
" ============================================================
set nocompatible
syntax on
filetype plugin indent on

set number
set ruler
set showmatch
set cursorline

" ============================================================
" Indentation (2 spaces)
" ============================================================
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smartindent

" Makefiles need tabs
augroup indent_overrides
  autocmd!
  autocmd FileType make setlocal noexpandtab tabstop=4 shiftwidth=4
augroup END

" ============================================================
" Search
" ============================================================
set incsearch
set hlsearch
set ignorecase
set smartcase

" ============================================================
" UI
" ============================================================
set t_Co=256
set background=dark
set noerrorbells
set novisualbell
set hidden
set splitbelow
set splitright
