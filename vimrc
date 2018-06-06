scriptencoding utf-8
set encoding=utf-8
set nocompatible

"
" Plugins.
"

call plug#begin('~/.vim/plugged')
    " General plugins.
    Plug 'Valloric/YouCompleteMe', {'do': 'bash install.py' } " Autocomplete.
    "Plug 'airblade/vim-gitgutter'            " Add git status in the gutter.
    Plug 'ctrlpvim/ctrlp.vim'                 " Easier file opening.
    Plug 'kristijanhusak/vim-hybrid-material' " Color scheme.
    Plug 'neomake/neomake'                    " Linting and building.
    Plug 'scrooloose/nerdcommenter'           " Easy comment out code.
    Plug 'terryma/vim-multiple-cursors'       " Multiple cursors.
    Plug 'vim-airline/vim-airline'            " Status bar.
    Plug 'arcticicestudio/nord-vim', { 'branch': 'develop' } " Color scheme.
    " Language Server Protocol (LSP).
    Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }

    " Language specific plugins.
    Plug 'cespare/vim-toml', {'for': 'toml'}
    Plug 'ekalinin/Dockerfile.vim', {'for': 'Dockerfile'}
    Plug 'elzr/vim-json', {'for': 'json'}
    Plug 'fatih/vim-go', {'for': 'go'}
    Plug 'leafgarland/typescript-vim', {'for': ['typescript', 'vue']}
    Plug 'mattn/emmet-vim', {'for': ['html', 'vue']}
    Plug 'othree/html5.vim', {'for': ['html', 'vue']}
    Plug 'pangloss/vim-javascript', {'for': ['javascript', 'vue']}
    Plug 'posva/vim-vue', {'for': 'vue'}
    Plug 'racer-rust/vim-racer', {'for': 'rust'}
    Plug 'rust-lang/rust.vim', {'for': 'rust'}
    Plug 'uarun/vim-protobuf', {'for': 'proto'}
call plug#end()

"
" Settings.
"

" General.
set relativenumber  " Relative line numbers.
set number          " Line numbers.
set nowrap          " No wrapping lines.
set textwidth=80    " Limit the width to 80.
set colorcolumn=81  " Color column 80.
highlight ColorColumn ctermbg=8
set belloff=all     " No more bells.
set mouse=a         " Mouse is useful.
set fileformat=unix " Unix file format.
set hidden          " Hide buffers rather then closing them.
set cb=unnamed      " Enable copy to clipboard.
set backspace=2     " Backspace like most apps.
set lazyredraw      " Only redraw when needed.
set showmatch       " Highlight matching bracket.
set formatoptions="tcroqwanj"

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
set background=dark
let g:nord_italic=1
let g:nord_italic_comments=1
let g:nord_uniform_status_lines=1
let g:nord_comment_brightness=20
colorscheme nord

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

"
" Commands involving the leader key.
"

" Set the leader to space, next use it to do everything.
let mapleader = "\<Space>"

" Open a file in the current project, or directory.
nmap <Leader>o :CtrlP<CR>
nmap <Leader>p :CtrlPCurWD<CR>

" Run emmit.
map <Leader>e <c-y>,

" Comment, or uncomment, a line.
nmap <Leader>c :call NERDComment("n", "Toggle")<CR>

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

" Go to Noemake errors.
map <Leader>fn ;lnext<CR>
map <Leader>fp ;lprevious<CR>
map <Leader>ff ;lfirst<CR>
map <Leader>fl ;llast<CR>

" Go to spell errors
map <Leader>sn ]s
map <Leader>sp [s

"
" Language specific commands.
"

" Run.
nnoremap <Leader>r :echoerr "No run command found"<CR>
:autocmd FileType go map <Leader>r :GoRun<CR>

" Test.
nnoremap <Leader>t :echoerr "No test command found"<CR>
:autocmd FileType go map <Leader>t :GoTest<CR>

" Make/check/lint.
nnoremap <Leader>m :Neomake \| :Neomake!<CR>

" Document.
nnoremap <Leader>d :echoerr "No document command found"<CR>
:autocmd FileType asciidoc map <Leader>d :call RunBuildScript()<CR>

" Build.
nnoremap <Leader>b :echoerr "No build command found"<CR>
:autocmd FileType go map <Leader>b :GoBuild<CR>
:autocmd FileType asciidoc map <Leader>b :call RunBuildScript()<CR>

" This function runs "build.sh" if it exists.
function! RunBuildScript()
  if filereadable('build.sh')
    terminal ++close ./build.sh
  else
    echoerr 'No build command found'
  endif
endfunction

"
" Plugin specific settings.
"

" Noemake makers for each language.
"let g:neomake_css_enabled_makers = ['csslint']
"let g:neomake_javascript_enabled_makers = ['eslint']
"let g:neomake_go_enabled_makers = ['go', 'golint', 'govet', 'gometalinter']

" Ctrl p ignore files according to .gitignore.
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" YouCompleteMe close the preview window after completion has completed.
let g:ycm_autoclose_preview_window_after_completion = 1

" Enable Emmet in insert, normal and view modes.
let g:user_emmet_mode='inv'

let g:LanguageClient_serverCommands = {
\ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }

let g:lsc_auto_map = v:true

"
" Language specific settings.
"

" Go
" Run goimports on save.
let g:go_fmt_command = 'goimports'
let g:go_metalinter_autosave = 1

" Rust
" Disable rustfmt, the formatted code is ugly.
let g:rustfmt_fail_silently = 1
let g:rust_recommended_style = 0
let g:rustfmt_autosave = 0
let g:ycm_rust_src_path = '~/.rustup/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src'
let g:lsc_server_commands = {'rust': 'rls'}
autocmd BufRead,BufNewFile *.rs set expandtab

" Clippy maker for Neomake.
" Eventough Neomake has a maker foor clippy using this custom one allows
" explicity setting the makers for rust files.
let g:neomake_rust_clippy_maker = {
    \ 'cwd': '%:p:h',
    \ 'exe': 'cargo',
    \ 'args': ['clippy', '--message-format=json', '--quiet'],
    \ 'append_file': 0,
    \ 'errorformat':
        \ '[%t%n] "%f" %l:%v %m,'.
        \ '[%t] "%f" %l:%v %m',
    \ 'process_output': function('neomake#makers#ft#rust#CargoProcessOutput'),
    \ }
let g:neomake_rust_enabled_makers = ['cargo', 'clippy']

" The location of the racer binary.
let g:racer_cmd = '~/bin/racer'
" Enable experimental showing of  complete function definition.
let g:racer_experimental_completer = 1

" Javascript related file detection.
autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json

" Markdown.
autocmd BufRead,BufNewFile *.md set filetype=markdown
