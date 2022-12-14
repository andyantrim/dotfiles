filetype plugin indent on          " filetype detection and settings
syntax on                          " syntax highlighting
silent! runtime macros/matchit.vim " matchit comes with Vim
set nocompatible                   " not strictly necessary but useful in some scenarii
set backspace=indent,eol,start     " let the backspace key work "normally"
set hidden                         " hide unsaved buffers
set incsearch                      " incremental search rules
set laststatus=2                   " not strictly necessary but good for consistency
set ruler                          " shows line number in the status line
set switchbuf=useopen,usetab       " better behavior for the quickfix window and :sb
set tags=./tags;/,tags;/           " search tags files efficiently
set wildmenu                       " better command line completion, shows a list of matches
set clipboard=unnamedplus
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set expandtab
set number
set relativenumber
set splitright splitbelow

" Vim Specific
set list
set listchars=tab:·\ 
set encoding=utf-8

nnoremap gb :buffers<CR>:sb<Space> 

call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'fatih/vim-go'
Plug 'junegunn/fzf'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rking/ag.vim'
call plug#end()

colorscheme github
let mapleader = " "

source ~/.config/nvim/nerd.vim
source ~/.config/nvim/tabs.vim
source ~/.config/nvim/go.vim
source ~/.config/nvim/fzf.vim
source ~/.config/nvim/coc.vim
