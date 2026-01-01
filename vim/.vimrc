" ============================================================
" Plugin manager: vim-plug
" ============================================================
" Installs plugins into ~/.vim/plugged
" If vim-plug is not installed:
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/.vim/plugged')

" Material colorscheme for Vim
Plug 'hzchirs/vim-material'

" ALE - Async linting and formatting
Plug 'dense-analysis/ale'

call plug#end()

" ============================================================
" Basic behavior
" ============================================================
set nocompatible                  " use Vim defaults, not old vi
syntax on                         " enable syntax highlighting
filetype plugin indent on         " intelligent indentation + filetype plugins

set number                        " show line numbers
set ruler                         " show cursor position (line/column)
set showmatch                     " briefly jump to matching bracket
set cursorline                    " highlight the current line

" ============================================================
" Indentation (default: 2 spaces)
" ============================================================
set tabstop=2                     " a tab character looks like 2 spaces
set shiftwidth=2                  " >> and auto-indent use 2 spaces
set softtabstop=2                 " backspace treats 2 spaces as a tab
set expandtab                     " convert tabs to spaces
set smartindent                   " smarter auto indentation

" Makefiles must use literal tab characters, not spaces
augroup indent_overrides
  autocmd!
  autocmd FileType make setlocal noexpandtab tabstop=4 shiftwidth=4
augroup END

" xml and plist: enforce 2-space indent even if global defaults change later
augroup plist_xml_indent
  autocmd!
  autocmd FileType xml,plist setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
augroup END

" ============================================================
" Search behavior
" ============================================================
set incsearch                     " highlight matches as you type
set hlsearch                      " highlight all matches
set ignorecase                    " case-insensitive search by default
set smartcase                     " unless you use capitals → then be case-sensitive

" ============================================================
" Clipboard
" ============================================================
" Your Vim has +clipboard. Using `unnamed` puts yank/delete into
" the macOS system clipboard (⌘C/⌘V compatible).
set clipboard=unnamed

" ============================================================
" Colors and UI
" ============================================================
set t_Co=256                      " 256-color support

" Material theme options:
"   default / darker / palenight / ocean
let g:material_theme_style = 'darker'

if has("termguicolors")
  set termguicolors               " full truecolor (Warp supports this)
endif

set background=dark               " optimize themes for dark terminals

try
  colorscheme vim-material
catch /^Vim\%((\a\+)\)\=:E185/
  " Material not installed yet, skip without failing
endtry

" ============================================================
" Key remapping
" ============================================================
nnoremap <Left> :echo "No left for you"<CR>
vnoremap <Left> :<C-u>echo "No left for you!"<CR>
inoremap <Left> <C-o>:echo "No left for you!"<CR>

nnoremap <Right> :echo "No right for you"<CR>
vnoremap <Right> :<C-u>echo "No right for you!"<CR>
inoremap <Right> <C-o>:echo "No right for you!"<CR>

nnoremap <Up> :echo "No up for you"<CR>
vnoremap <Up> :<C-u>echo "No up for you!"<CR>
inoremap <Up> <C-o>:echo "No up for you!"<CR>

nnoremap <Down> :echo "No down for you"<CR>
vnoremap <Down> :<C-u>echo "No down for you!"<CR>
inoremap <Down> <C-o>:echo "No down for you!"<CR>

" ============================================================
" Misc quality of life
" ============================================================
set noerrorbells                  " no terminal bell on errors
set novisualbell                  " no screen flash either
set hidden                        " switch buffers without saving
set splitbelow                    " when splitting, place new window below
set splitright                    " vertical splits appear to the right
" set mouse=a                     " uncomment to enable mouse support
set textwidth=100                 " wrap at 100 columns (matches VS Code)
set fixendofline                  " ensure files end with a newline
set endofline                     " write the final newline

" ============================================================
" ALE (Linting + Formatting)
" ============================================================
let g:ale_linters_explicit = 1
let g:ale_linters = {
\   'python': ['ruff'],
\   'javascript': ['eslint'],
\   'rust': ['analyzer'],
\   'yaml': ['yamllint'],
\}
let g:ale_fixers = {
\   '*': ['trim_whitespace'],
\   'html': ['prettier'],
\   'css': ['prettier'],
\   'javascript': ['prettier'],
\   'json': ['prettier'],
\   'yaml': ['prettier'],
\   'python': ['ruff', 'ruff_format'],
\   'sh': ['shfmt'],
\   'rust': ['rustfmt'],
\}
let g:ale_fix_on_save = 1
let g:ale_sh_shfmt_options = '-i 2 -ci -sr'
