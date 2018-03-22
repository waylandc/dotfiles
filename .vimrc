
" Wayland's vim setup

call plug#begin()
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'w0rp/ale' " Async Lint Engine
Plug 'vim-airline/vim-airline'
Plug 'skywind3000/asyncrun.vim'
Plug 'justinmk/vim-dirvish'
Plug 'morhetz/gruvbox'
Plug 'leshill/vim-json' "json highlighting
Plug 'tpope/vim-fugitive' "git commands
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

filetype plugin indent on

set autoindent
set tabstop=4
set expandtab "use spaces instead of tabs
set shiftwidth=4
set smartindent
set nocompatible
set scrolloff=3 "start scrolling when 3 lines from edge
set sidescroll=1 "scroll horizontally by 1 column
set sidescrolloff=4 "start scrolling horizontally when 4 lines from edge
syntax on " syntax highlighting
set ruler " Ruler on
set number relativenumber " Line numbers on
" only use relativenumber on window with focus
:augroup numbertoggle
:   autocmd!
:   autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:   autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
:augroup END
" Only display line numbers for the active pane
:au WinEnter * :setlocal number
:au WinLeave * :setlocal nonumber
" Automatically resize vertical splits
:au WinEnter * :set winfixheight
:au WinEnter * :wincmd =

set bs=2 " Backspace over everything in insert mode
set history=500 " Number of things to remember in history

set ic " Case insensitive search
set hls " Highlight search
set showmatch " Show matching brackets
set showcmd
set cmdheight=2
set laststatus=2
set wrap
set linebreak

colorscheme gruvbox
set background=dark

" Javascript related stuff
" run eslint prettier each time we save JS files
autocmd BufWritePost *.js AsyncRun -post=checktime ./node_modules/.bin/eslint --fix %
" turn on vim-javascript flow support
let g:javascript_plugin_flow = 1
" turn on vim-jsx support for .js files
let g:jsx_ext_required = 0

function! FormatJSON()
    :%!python -m json.tool
endfunction

" Change cursor line darker on insert
autocmd InsertEnter * hi CursorLine cterm=NONE ctermbg=28
autocmd InsertLeave * hi CursorLine cterm=NONE ctermbg=black
