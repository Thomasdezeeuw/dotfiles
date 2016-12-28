set nocompatible

"
" Plugins.
"

" NeoBundle.vim required stuff.
set runtimepath^=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

" General plugins.
NeoBundle 'vim-airline/vim-airline'            " Status bar.
NeoBundle 'ctrlpvim/ctrlp.vim'                 " Easier file opening.
NeoBundle 'Valloric/YouCompleteMe'             " Autocomplete.
NeoBundle 'tpope/vim-surround'                 " Easy surrounding text.
NeoBundle 'kristijanhusak/vim-hybrid-material' " Color scheme.
NeoBundle 'vim-syntastic/syntastic'            " Synthax hightlighting improved.
NeoBundle 'tpope/vim-fugitive'                 " Git support.
NeoBundle 'airblade/vim-gitgutter'             " Add git status in the gutter.

" Language specific.
NeoBundle 'fatih/vim-go'            " Go greatness.
NeoBundle 'rust-lang/rust.vim'      " Rust support.
NeoBundle 'timonv/vim-cargo'        " Cargo support for Rust.
NeoBundle 'elzr/vim-json'           " Better support for JSON.
NeoBundle 'othree/html5.vim'        " HTML.
NeoBundle 'mattn/emmet-vim'         " Emmet.
NeoBundle 'posva/vim-vue'           " Vue components.
NeoBundle 'pangloss/vim-javascript' " Javascript.
NeoBundle 'uarun/vim-protobuf'      " Protocol buffers.
NeoBundle 'ekalinin/Dockerfile.vim' " Dockerfile.

" Check if all plugins are available.
NeoBundleCheck

" Setup the plugins.
call neobundle#end()

"
" Settings.
"

" General.
set number          " Line numbers.
set nowrap          " No wrapping lines.
set textwidth=80    " Limit the width to 80.
set colorcolumn=80  " Color column 80.
highlight ColorColumn ctermbg=8
set noerrorbells    " Stop beeping.
set visualbell      " Flash on beeps.
set mouse=a         " Mouse is usefull.
set fileformat=unix " Unix file format.
set hidden          " Hide buffers rather then closing them.
set cb=unnamed      " Enable copy to clipboard.

" Identation.
set nojoinspaces " Single space between text lines. Like this one.
set autoindent   " Use identation from previous line.
set smartindent  " Smart indentation.
set smarttab     " Smart tabs.
set tabstop=2    " Tab width of 2.
set shiftwidth=2
set softtabstop=0
set noexpandtab  " Use actual tabs.
filetype plugin indent on " Smart identation based on the file type.
set timeoutlen=150 " Change timeout for commands.

" Search options.
set smartcase " Ignore case if lowercase when searching.
set hlsearch  " Highlight search matches.
set incsearch " Search whiling typing.

" Disable backup files, use git instead.
set nobackup
set noswapfile

" Trim whitespace on save.
autocmd BufWritePre * :%s/\s\+$//e

" Color scheme.
syntax on                   " Synthax highlighting.
set background=dark         " Dark background.
colorscheme hybrid_material " Color scheme.
let g:enable_bold_font = 1  " We're using a modern terminal.

"
" Shortcuts.
"

" Press Q to wrap the current paragraph.
" TODO(Thomas): this messes up the code following the command sometimes. Current
" work around is to insert a temporary empty line, format and remove the empty
" line.
vmap Q gq
nmap Q gqap

" No more `:w`, but `;w`, so no more `:W` on accident.
nnoremap ; :

" Set the leader to space, next use it to do everything.
let mapleader = "\<Space>"

" Open a file using space-o.
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>p :CtrlPCurWD<CR>
" Run emmit on space-e.
map <Leader>e <c-y>,
" Undo and redo, on space-z and space-y.
map <Leader>z u
map <Leader>y <c-r>

" Mapping space-r to running command, depending on the language.
nnoremap <Leader>r :echoerr "No run command found"<CR>
:autocmd FileType go map <Leader>r :GoRun<CR>
:autocmd FileType rust map <Leader>r :CargoRun<CR>
:autocmd FileType java map <Leader>r :! java_run<CR>

" Mapping space-t to running the test command, depening on the language.
nnoremap <Leader>t :echoerr "No test command found"<CR>
:autocmd FileType go map <Leader>t :GoTest<CR>
:autocmd FileType rust map <Leader>t :CargoTest<CR>

" TODO(Thomas): add code folding.
" Space/Ctrl/Command-0 -> show all
" Space/Ctrl/Command-{1,9} -> fold level {1,9}.

" Sudo save, after you opened the file without sudo.
" Credit to Steve Losh (the URL is no more).
cmap w!! w !sudo tee % > /dev/null

"
" Plugin specific settings.
"

" Checker for each language
let g:syntastic_css_checkers = ['csslint']
let g:syntastic_javascript_checkers = ['jshint', 'eslint']

" Ctrl p ignore files according to .gitignore.
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" YouCompleteMe close the preview window after completion has completed.
let g:ycm_autoclose_preview_window_after_completion = 1

"
" Language specific settings.
"

" Go
" Run goimports on save.
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 1

" Rust
" Run rustfmt on save, see https://github.com/rust-lang/rust.vim/issues/109 for
" the second line.
let g:rustfmt_autosave = 1
let g:rustfmt_fail_silently = 1
"let g:ycm_rust_src_path = systemlist('rustc --print sysroot')[0] . '/lib/...'

" Javascript related file detection.
autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json

" Markdown.
autocmd BufRead,BufNewFile *.md set filetype=markdown

" Enable Emmet in all modes.
let g:user_emmet_mode='inv'
