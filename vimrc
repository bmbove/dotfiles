set nocompatible
set nofoldenable

" Bundle Support
filetype on
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

"---encoding stuff---
set encoding=utf-8
set termencoding=utf-8
setglobal fileencoding=utf-8

" solarized colors
Bundle 'altercation/vim-colors-solarized'

" Nifty status bar and prompts for bash, tmux, etc
Bundle 'bling/vim-airline'

" Shows buffers in status bar - NOTE: slows down command-t
"Bundle 'bling/vim-bufferline'

" Easy commenting
Bundle 'scrooloose/nerdcommenter'

" File tree 
Bundle 'scrooloose/nerdtree'

" python tools
"Bundle 'klen/python-mode'

" latex stuff
Bundle 'gerw/vim-latex-suite'

" better python syntax highlighting
Bundle 'python.vim'

" git wrapper that I probably won't use
"Bundle 'tpope/vim-fugitive'

" arduino compaitibility
Bundle 'jplaut/vim-arduino-ino'

" useful indent guides 
Bundle 'nathanaelkane/vim-indent-guides'

" javascript syntax highlighting
"Bundle 'pangloss/vim-javascript'
"Bundle 'mxw/vim-jsx'

" quick file find
Bundle 'wincent/command-t'

"--- over 80 characters highlight for python files --
au BufRead,BufNewFile *.py highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
au BufNewFile,BufRead *.py match OverLength /\%>79v.\+/

"--- enable settings read from top of file ---
set modeline

"--- 80 char column marker ---
set colorcolumn=80

"---color scheme---
syntax on
"set t_Co=256
set background=dark
"colorscheme solarized
if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
    "let g:solarized_termcolors=256
    let g:solarized_termcolors=&t_Co
    let g:solarized_termtrans=1
    let g:solarized_contrast="normal"
    let g:solarized_visibility="normal"
    color solarized             " Load a colorscheme
endif

" Text Format
"---indentation---
" smartindent breaks for python comments
"set smartindent  "indent smartly
set tabstop=4    "4-space tabs
set sts=4        "fix backspace for tabs
set shiftwidth=4 "4-space indent
set autoindent   "auto indent same as previous
set smarttab
set expandtab    "tabs -> spaces
set shiftround   "round spaces to meet indentation
set backspace=2
set whichwrap=h,l,~,[,] "h and l will wrap on lines
set spell                           " Spell checking on
set hidden                          " Allow buffer switching without saving
set number
"highlight Comment cterm=italic

"---searching options---
set ignorecase "case insensitive matching
set smartcase  "case sensitive matching when I use uppercase
set nohls      "no highlight for searches
set incsearch  "search as you type
set magic      "magic regex
set wildignore=*.o,*.obj,*.bak,*.exe,*.so,*.dll,*.pyc,.sv,.hg,.bzr,.git


"---visual---
set showmatch  " show matching brackets
set history=1000                    " Store a ton of history (default is 20)
highlight clear LineNr          " Current line number row will have same background color in relative mode
highlight clear SignColumn      " SignColumn should match background
set showmode                    " Display the current mode
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

"---keyboard stuff---
set pastetoggle=<F2>
let mapleader = ','
nnoremap Y y$
" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>                                                                                                                       
nmap <silent> <c-j> :wincmd j<CR>                                                                                                                       
nmap <silent> <c-h> :wincmd h<CR>                                                                                                                       
nmap <silent> <c-l> :wincmd l<CR>

"--- general config --

"---jump to last pos in file ---
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

set backup                  " Backups are nice ...
if has('persistent_undo')
    set undofile                " So is persistent undo ...
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif

if has('cmdline_info')
    set ruler                   " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                 " Show partial commands in status line and
                                " Selected characters/lines in visual mode
endif

if has('statusline')
    set laststatus=2
    " Broken down into easily includeable segments
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    "set statusline+=%{fugitive#statusline()} " Git Hotness
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif


" vim-airline {
    let g:airline_theme = 'solarized' " 'powerlineish' is another choice
    if !exists('g:airline_powerline_fonts')
        " Use the default set of separators with a few customizations
        let g:airline_left_sep='›'  " Slightly fancier than '>'
        let g:airline_right_sep='‹' " Slightly fancier than '<'
    endif
" }
"
    " PyMode {
        let g:pymode_lint_checker = "pyflakes"
        let g:pymode_utils_whitespaces = 0
        let g:pymode_options = 0
        let g:pymode_lint_ignore="E265,E113"
    " }
    " PythonMode {
        " Disable if python support not present
        if !has('python')
            let g:pymode = 1
        endif
    " }

" Initialize directories {
function! InitializeDirectories()
    let parent = $HOME
    let prefix = 'vim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

    if exists('g:spf13_consolidated_directory')
        let common_dir = g:spf13_consolidated_directory . prefix
    else
        let common_dir = parent . '/.' . prefix
    endif

    for [dirname, settingname] in items(dir_list)
        let directory = common_dir . dirname . '/'
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction
call InitializeDirectories()
" }
"
let g:pymode_rope_lookup_project = 0

let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1

" latex compile to pdf
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats = 'pdf, aux'

filetype plugin indent on

let g:jsx_ext_required = 0 " Allow JSX in normal JS files
" shared registers across instances 
set clipboard=unnamed

" command-t ignore node_modules
set wildignore+=.git/*,node_modules/*,*.pyc,dist/*
