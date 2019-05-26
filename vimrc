scriptencoding utf-8
set encoding=utf-8
set nocompatible

"
" Plugin specific settings.
"

" Don't use the default mappings.
let g:NERDCreateDefaultMappings=0

" Ctrl p ignore files according to .gitignore.
let g:ctrlp_user_command=['.git', 'cd %s && git ls-files -co --exclude-standard']

"
" Plugins.
"

call plug#begin('~/.vim/plugged')
    " General plugins.
    Plug 'airblade/vim-gitgutter'       " Add git status in the gutter.
    Plug 'ctrlpvim/ctrlp.vim'           " Easier file opening.
    Plug 'morhetz/gruvbox'              " Sepia color scheme.
    Plug 'scrooloose/nerdcommenter'     " Easy comment out code.
    Plug 'terryma/vim-multiple-cursors' " Multiple cursors.
    Plug 'vim-airline/vim-airline'      " Status bar.

    " Language specific plugins.
    Plug 'cespare/vim-toml', {'for': 'toml'}
    Plug 'ekalinin/Dockerfile.vim', {'for': 'Dockerfile'}
    Plug 'elzr/vim-json', {'for': 'json'}
    Plug 'fatih/vim-go', {'for': 'go'}
    Plug 'leafgarland/typescript-vim', {'for': ['typescript', 'vue']}
    Plug 'lervag/vimtex', {'for': 'tex'}
    Plug 'mattn/emmet-vim', {'for': ['html', 'vue']}
    Plug 'othree/html5.vim', {'for': ['html', 'vue']}
    Plug 'pangloss/vim-javascript', {'for': ['javascript', 'vue']}
    Plug 'posva/vim-vue', {'for': 'vue'}
    Plug 'rust-lang/rust.vim', {'for': 'rust'}
    Plug 'uarun/vim-protobuf', {'for': 'proto'}
call plug#end()

"
" Settings.
"

" General.
set relativenumber  " Relative line numbers.
set number          " Line numbers.
set signcolumn=yes  " Always show sign column.
set nowrap          " No wrapping lines.
set textwidth=80    " Limit the width to 80.
set colorcolumn=81  " Color column 80.
highlight ColorColumn ctermbg=8
set belloff=all     " No more bells.
" FIXME: for whatever reason something a mouse click will close a tab, very
" annoying when working. Find the cause, fix it and set mouse back to `a`.
set mouse=         " Disable the mouse.
set fileformat=unix " Unix file format.
set hidden          " Hide buffers rather then closing them.
set cb=unnamed      " Enable copy to clipboard.
set backspace=2     " Backspace like most apps.
set lazyredraw      " Only redraw when needed.
set showmatch       " Highlight matching bracket.
set formatoptions=tcroqwanj
let $IN_VIM=1       " Let the shell know we're in Vim.
set shell=/usr/local/bin/bash\ -il " Use our preferred shell.

" Indentation.
set nojoinspaces   " Single space between text lines. Like this one.
set autoindent     " Use indentation from previous line.
set smartindent    " Smart indentation.
set smarttab       " Smart tabs.
set tabstop=4      " Tab width of 4.
set softtabstop=4  " Insert 4 spaces on tab.
set shiftwidth=4   " Insert 4 spaces.
set noexpandtab    " Insert actual tabs.
set timeoutlen=250 " Change timeout for commands.

" Search options.
set smartcase " Ignore case if lowercase when searching.
set hlsearch  " Highlight search matches.
set incsearch " Search whiling typing.

" Disable backup files, use git instead.
set nobackup
set noswapfile

" Enable spell check
set spell

" Trim whitespace on save.
autocmd BufWritePre * :%s/\s\+$//e

" Colours and such.
set termguicolors
syntax on
set background=light
let g:gruvbox_italic=1
let g:gruvbox_contrast_light='soft'
colorscheme gruvbox

" Show invisible characters
set listchars=tab:»·,precedes:·,trail:·
set list

" Code folding.
set foldenable
set foldmethod=indent
set foldlevel=100
set foldminlines=1

"
" Shortcuts.
"

" No more `:w`, but `;w`, so no more `:W` on accident.
nnoremap ; :

" Sudo save, after you opened the file without sudo.
" Credit to Steve Losh (the URL is no more).
cmap w!! w !sudo tee % > /dev/null

" Disable Ex mode.
map Q <Nop>

" Disable space and the arrow keys.
map <Space> <nop>
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Wrap the selected text.
vmap Q gq

" Match `D`, but with copying.
map Y y$

" Make J and K emulate page down and up, in addition to having ctrl-d and
" ctrl-u.
nmap J 15j
nmap K 15k

"
" Commands involving the leader key.
"

" Set the leader to space, next use it to do everything.
let mapleader="\<Space>"

" Open a file in the current project, or directory.
nmap <Leader>o :CtrlP<CR>

" Comment, or uncomment, a line.
nmap <Leader>c <plug>NERDCommenterToggle

" Tab opening.
map <Leader>1 1gt
map <Leader>2 2gt
map <Leader>3 3gt
map <Leader>4 4gt
map <Leader>5 5gt
map <Leader>6 6gt
map <Leader>7 7gt
map <Leader>8 8gt
map <Leader>9 9gt

" Code folding.
map <Leader>k0 :setlocal foldlevel=100<CR>
map <Leader>k1 :setlocal foldlevel=0<CR>
map <Leader>k2 :setlocal foldlevel=1<CR>
map <Leader>k3 :setlocal foldlevel=2<CR>
map <Leader>k4 :setlocal foldlevel=3<CR>
map <Leader>k5 :setlocal foldlevel=4<CR>

" Go to spell errors
map <Leader>sn ]s
map <Leader>sp [s

" Alias various make commands.
map <Leader>m :make<CR>
map <Leader>b :make build<CR>
map <Leader>d :make doc<CR>
map <Leader>r :make run<CR>
map <Leader>t :make test<CR>

"
" Language specific settings.
"

" Go
" Run goimports on save.
let g:go_fmt_command='goimports'
let g:go_metalinter_autosave=1
autocmd FileType go set makeprg=go\ $*

" Rust
" Disable rustfmt, the formatted code is ugly.
let g:rustfmt_fail_silently=1
let g:rust_recommended_style=0
let g:rustfmt_autosave=0
autocmd BufRead,BufNewFile *.rs set expandtab
autocmd FileType rust set makeprg=cargo\ $*

" LaTeX.
autocmd FileType tex set makeprg=pdflatex\ %
