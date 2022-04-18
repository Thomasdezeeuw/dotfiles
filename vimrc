" Location: ~/.vim/vimrc
" Plugin manager: https://github.com/junegunn/vim-plug

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

" Note: this needs to be done after the plugin is loaded.
"autocmd! gitgutter CursorHold,CursorHoldI " Place in `.vim/after/plugin/gitgutter.vim`.
" Only show Git changes after saving the file.
autocmd BufWritePost * GitGutter

"
" Plugins.
"

call plug#begin('~/.vim/plugged')
    " General plugins.
    Plug 'Valloric/YouCompleteMe'       " Completion.
    Plug 'airblade/vim-gitgutter'       " Add git status in the gutter.
    Plug 'ctrlpvim/ctrlp.vim'           " Easier file opening.
    Plug 'editorconfig/editorconfig-vim'" Support EditorConfig.
    Plug 'morhetz/gruvbox'              " Sepia color scheme.
    Plug 'mtdl9/vim-log-highlighting'   " Highlighting for logs.
    Plug 'scrooloose/nerdcommenter'     " Easy comment out code.
    Plug 'terryma/vim-multiple-cursors' " Multiple cursors.
    Plug 'tpope/vim-obsession'          " Automatic storing of session data.
    Plug 'tpope/vim-sleuth'             " Automatically adjust tab size and space/tab.
    Plug 'vim-airline/vim-airline'      " Status bar.

    " Language specific plugins.
    Plug 'LnL7/vim-nix', {'for': 'nix'}
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
set formatoptions=crqjn
" Recognise the following lists:
" 1 Numbered.
" 1. Numbered with period.
" 11 With two digits.
" 11. With two digits and period.
" - Lines
" * Asterisk.
" FIXME: this breaks indentation.
"set formatlistpat="^\s*[\(\d\+\.\=)-\*]\s*"
let $IN_VIM=1       " Let the shell know we're in Vim.
set shell=$SHELL    " Use our preferred shell and options.

" Indentation.
set nojoinspaces   " Single space between text lines. Like this one.
set autoindent     " Use indentation from previous line.
set smartindent    " Smart indentation.
set smarttab       " Smart tabs.
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
set foldminlines=0

" Explorer settings.
let g:netrw_banner=0
"let g:netrw_liststyle=3 " Tree like explorer.
" Open with `;Vec`.
let g:netrw_winsize=25
"let g:netrw_browse_split=4 " FIXME: only do this for :Vexplorer.

" Highlight REQUEST as keyword.
syn keyword logLevelNotice REQUEST
" Log line tend to be long.
autocmd FileType log setlocal wrap

" YouCompleteMe settings.
let g:ycm_complete_in_comments=1
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_auto_hover=''
set completeopt=menu,popup
" TODO: add shortcut to manually trigger the YCM hover command.

" Use ripgrep for `:grep`.
if executable('rg')
    set grepprg=rg\ --vimgrep
endif

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
map <Leader>k6 :setlocal foldlevel=5<CR>
map <Leader>k7 :setlocal foldlevel=6<CR>
map <Leader>k8 :setlocal foldlevel=7<CR>
map <Leader>k9 :setlocal foldlevel=8<CR>

" Movement around errors.
" TODO: overwritten by make below.
map <Leader>mn ;cnext<CR>
map <Leader>mp ;cprevious<CR>
map <Leader>mf ;cfirst<CR>
map <Leader>ml ;clast<CR>

" Go to spell errors
map <Leader>sn ]s
map <Leader>sp [s

" Alias various make commands.
map <Leader>m :make<CR>
map <Leader>b :make build<CR>
map <Leader>d :make doc<CR>
map <Leader>r :make run<CR>
map <Leader>t :make test<CR>

" Formatting.
autocmd FileType json map <Leader>f :%!python3 -m json.tool<CR>

" Marking:
" m$ sets mark to $.
" `$ go to mark $.


"
" Language specific settings.
"

" Go
" Run goimports on save.
let g:go_fmt_command='goimports'
let g:go_metalinter_autosave=1
autocmd FileType go set makeprg=go\ $*
" Don't automatically update binaries. That is not the job of Vim-go.
let g:go_get_update = 0
" Don't overwrite K.
let g:go_doc_keywordprg_enabled = 0
" Don't close my folds on save, see https://github.com/fatih/vim-go/issues/502.
let g:go_fmt_experimental = 1
" Leave alone, I know what to do.
" Don't move my fcking cursor!
let g:go_jump_to_error = 1

" Rust
let g:rustfmt_autosave=1
let g:rustfmt_command='rustup run stable rustfmt'
autocmd FileType rust set makeprg=cargo\ $*
autocmd FileType rust set textwidth=80
if executable('rust-analyzer')
    let g:ycm_language_server =
    \ [
    \   {
    \       'name': 'rust',
    \       'cmdline': ['rust-analyzer'],
    \       'filetypes': ['rust'],
    \       'project_root_files': ['Cargo.toml']
    \   }
    \ ]
    " Additional configuration (for some reason in Python).
    let g:ycm_global_ycm_extra_conf = '~/.vim/vim_ycm_conf.py'
endif
autocmd FileType rust let b:ycm_hover = { 'command': 'GetDoc', 'syntax': &syntax }

" LaTeX.
autocmd FileType tex set makeprg=pdflatex\ %
let g:tex_flavor = 'latex'
let g:vimtex_compiler_enabled = 0 " Gives a warning.
