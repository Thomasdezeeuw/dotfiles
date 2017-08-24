scriptencoding utf-8
set encoding=utf-8
set nocompatible

"
" Plugins.
"

" NeoBundle.vim required stuff.
set runtimepath^=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

" General plugins.
NeoBundle 'Valloric/YouCompleteMe'             " Autocomplete.
NeoBundle 'airblade/vim-gitgutter'             " Add git status in the gutter.
NeoBundle 'ctrlpvim/ctrlp.vim'                 " Easier file opening.
NeoBundle 'kristijanhusak/vim-hybrid-material' " Color scheme.
NeoBundle 'scrooloose/nerdcommenter'           " Easy comment out code.
"NeoBundle 'tpope/vim-fugitive'                " Git support.
NeoBundle 'tpope/vim-surround'                 " Easy surrounding text.
NeoBundle 'vim-airline/vim-airline'            " Status bar.
NeoBundle 'neomake/neomake'                    " Linting and code checking.
NeoBundle 'terryma/vim-multiple-cursors'       " Mutliple cursors.

" Language specific.
NeoBundleLazy "fatih/vim-go", {'filetypes': ['go']}
NeoBundleLazy 'rust-lang/rust.vim', {'filetypes': ['rust']}
NeoBundleLazy 'rust-lang/rust.vim', {'filetypes': ['rust']}
NeoBundleLazy 'timonv/vim-cargo', {'filetypes': ['rust']}
NeoBundleLazy 'racer-rust/vim-racer', {'filetypes': ['rust']}
NeoBundleLazy 'pangloss/vim-javascript', {'filetypes': ['javascript']}
NeoBundleLazy 'leafgarland/typescript-vim', {'filetypes': ['typescript']}
NeoBundleLazy 'posva/vim-vue', {'filetypes': ['vue']}
NeoBundleLazy 'othree/html5.vim', {'filetypes': ['html']}
NeoBundleLazy 'mattn/emmet-vim', {'filetypes': ['html', 'vue']}
NeoBundleLazy 'elzr/vim-json', {'filetypes': ['json']}
NeoBundleLazy 'cespare/vim-toml', {'filetypes': ['toml']}
NeoBundleLazy 'ekalinin/Dockerfile.vim', {'filetypes': ['Dockerfile']}
NeoBundleLazy 'uarun/vim-protobuf', {'filetypes': ['proto']}

" Check if all plugins are available.
NeoBundleCheck

" Setup the plugins.
call neobundle#end()

"
" Settings.
"

" General.
set relativenumber  " Relative line numbers.
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
set backspace=2     " Backspace like most apps.
set lazyredraw      " Only redraw when needed.
set showmatch       " Highlight matching bracket.
set formatoptions="tcroqwanlj"
set nopaste

" Identation.
set nojoinspaces   " Single space between text lines. Like this one.
set autoindent     " Use identation from previous line.
set smartindent    " Smart indentation.
set smarttab       " Smart tabs.
set tabstop=4      " Tab width of 4.
set softtabstop=4  " Insert 4 spaces on tab.
set shiftwidth=4   " Insert 4 spaces.
set expandtab      " Insert actual spaces.
set timeoutlen=250 " Change timeout for commands.
filetype plugin indent on " Smart identation based on the file type.

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

" Show invisible characters
set listchars=tab:»·,space:·,precedes:·
set list

" Code folding.
set foldenable
set foldmethod=indent
set foldlevel=0 " Start with every fold closed.
set foldminlines=1

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

" Sudo save, after you opened the file without sudo.
" Credit to Steve Losh (the URL is no more).
cmap w!! w !sudo tee % > /dev/null

" Disable the arrow keys.
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

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

" Tab openining.
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

" Goto Noemake errors.
map <Leader>fn ;lnext<CR>
map <Leader>fp ;lprevious<CR>
map <Leader>ff ;lfirst<CR>
map <Leader>fl ;llast<CR>

"
" Language depening commands.
"

" Run.
nnoremap <Leader>r :echoerr "No run command found"<CR>
:autocmd FileType go map <Leader>r :GoRun<CR>
:autocmd FileType rust map <Leader>r :CargoRun<CR>

" Test.
nnoremap <Leader>t :echoerr "No test command found"<CR>
:autocmd FileType go map <Leader>t :GoTest<CR>
:autocmd FileType rust map <Leader>t :CargoTest<CR>

" Make/check/lint.
nnoremap <Leader>m :echoerr "No make command found"<CR>
:autocmd FileType go map <Leader>m :Neomake<CR>
:autocmd FileType rust map <Leader>m :Neomake! clippy<CR>

" Document.
nnoremap <Leader>d :echoerr "No document command found"<CR>
:autocmd FileType rust map <Leader>d :CargoDoc<CR>

" Build.
nnoremap <Leader>b :echoerr "No build command found"<CR>
:autocmd FileType go map <Leader>b :GoBuild<CR>
:autocmd FileType rust map <Leader>b :CargoBuild<CR>
:autocmd FileType asciidoc map <Leader>b :call RunBuildScript()<CR>

" This function run "build.sh" if it exists.
function! RunBuildScript()
  if filereadable('build.sh')
    ! ./build.sh
  else
    echoerr 'No build command found'
  endif
endfunction

"
" Plugin specific settings.
"

" Noemake makers for each language.
let g:neomake_css_enabled_makers = ['csslint']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_go_enabled_makers = ['go', 'golint', 'govet', 'gometalinter']

" Ctrl p ignore files according to .gitignore.
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" YouCompleteMe close the preview window after completion has completed.
let g:ycm_autoclose_preview_window_after_completion = 1

" Enable Emmet in insert, normal and view modes.
let g:user_emmet_mode='inv'

"
" Language specific settings.
"

" Go
" Run goimports on save.
let g:go_fmt_command = 'goimports'
let g:go_metalinter_autosave = 1

" Rust
" Run rustfmt on save, see https://github.com/rust-lang/rust.vim/issues/109 for
" the second line.
let g:rustfmt_fail_silently = 1
let g:rust_recommended_style = 0
let g:rustfmt_autosave = 0 " Creates too much weird code...
let g:ycm_rust_src_path = '~/.rustup/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src'

" The location of the racer binary.
let g:racer_cmd = '~/bin/racer'
" Enable experimental showing of  complete function definition.
let g:racer_experimental_completer = 1

" Javascript related file detection.
autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json

" Markdown.
autocmd BufRead,BufNewFile *.md set filetype=markdown
