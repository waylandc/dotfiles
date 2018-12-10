
" Wayland's vim setup

augroup AutoReloadVimRC
  autocmd!
  "automatically reload vimrc on save
  au BufWritePost .vimrc so ~/.vimrc
augroup END

" We use Vundle for our plugins
call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'chriskempson/tomorrow-theme'
Plug 'flazz/vim-colorschemes'
" Plug 'nightsense/stellarized'
" Plug 'nightsense/nemo'
Plug 'nightsense/snow'
Plug 'nightsense/stellarized'
Plug 'sheerun/vim-polyglot'
Plug 'pangloss/vim-javascript'
Plug 'vim-syntastic/syntastic'
Plug 'posva/vim-vue'
Plug 'w0rp/ale' " Async Lint Engine
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'elzr/vim-json' "json highlighting
" Plug 'tpope/vim-fugitive' "git commands
Plug 'christoomey/vim-tmux-navigator'
Plug 'fatih/vim-go'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'Valloric/YouCompleteMe'
call plug#end()

" Theme and styling
set t_Co=256
set background=dark
colorscheme snow 

filetype plugin indent on

set nocompatible            " Must come first because it changes other options
let mapleader=","           " remap our leader from \ to ,
set hidden                  " hides buffers even if they have unsaved changes
set cursorline              " highlight line containing cursor
set visualbell              " don't beep
set noerrorbells            " don't beep
set incsearch               " Highlight matches as you type
set hlsearch                " Highlight matches
set autoindent
set tabstop=2
set softtabstop=2           " tab width
set expandtab               " Use spaces instead of tabs
set shiftwidth=2
set shiftround              " Round spaces to nearest shiftwidth multiple
set smartindent
set scrolloff=3             " Start scrolling when 3 lines from edge
set sidescroll=1            " Scroll horizontally by 1 column
set sidescrolloff=4         " Start scrolling horiz when 4 lines from edge
syntax enable               " syntax highlighting
scriptencoding utf-8
set encoding=UTF-8
set ruler                   " Show cursor posn at right side of status line
set number relativenumber   " Line numbers on
set autoread                " if file changed since opening, auto read it
set bs=2                    " Backspace over everything in insert mode
set history=100             " Number of things to remember in history
set showmatch               " Show matching brackets
set showcmd                 " Display incomplete commands
set wrap
set linebreak
set rtp+=~/.fzf

if exists('+colorcolumn')
  " vim 7.3+ supports colorcolumn
  set colorcolumn=80
endif

" if has('gui_running')
"   set guifont=DroidSansMono_NF:h11:cANSI:qDRAFT
"   set lines=80 columns=125
" endif

" only use relativenumber on window with focus
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

" Only display line numbers for the active pane
au WinEnter * :setlocal number
au WinLeave * :setlocal nonumber
" Automatically resize vertical splits
" au WinEnter * :set winfixheight
" au WinEnter * :wincmd =


" :call FormatJSON()
function! FormatJSON()
    :%!python -m json.tool
endfunction

" Enable fzf within vim
nnoremap <leader>p :History<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>t :Files<CR>

" move between buffers using Fn key
nnoremap <F1> :bp<cr>
nnoremap <F2> :bn<cr>

let g:ale_linters = {'javascript': ['eslint']}
"let g:ale_linters = {'javascript': ['prettier', 'eslint']}
"let g:ale_fixers = {'javascript': ['eslint']}
"let g:ale_set_highlights = 0  "disables all ALE highlighting
let g:ale_fix_on_save = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1 
"let g:ale_sign_error = '●'
"let g:ale_sign_warning = '.'
let g:ale_lint_on_save = 1

nnoremap ; :
" make moving between split windows easier
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable display all buffers in tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#show_splits = 1
let g:airline_theme='angr'
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts=1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"------------------------------------------------------------------------------
" Syntastic
"------------------------------------------------------------------------------
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"------------------------------------------------------------------------------
" NERDTree
"------------------------------------------------------------------------------

" General properties
let NERDTreeDirArrows=1
let NERDTreeMinimalUI=1
let NERDTreeIgnore=['\.o$', '\.pyc$', '\.php\~$']
let NERDTreeWinSize = 35
" close tree after opening a file
let NERDTreeQuitOnOpen=1
" Make sure that when NT root is changed, Vim's pwd is also updated
let NERDTreeChDirMode = 2
let NERDTreeShowLineNumbers = 1
let NERDTreeAutoCenter = 1

"nmap <C-l> :call NERDComment('n','toggle')<cr>
"vmap <C-l> :call NERDComment('v','toggle')<cr>
" Open NERDTree on startup, when no file has been specified
autocmd VimEnter * if !argc() | NERDTree | endif

" Locate file in hierarchy quickly
"WC conflicts with fzf bind
"map <leader>T :NERDTreeFind<cr>

" Toogle on/off
nmap <leader>o :NERDTreeToggle<cr>

" after C+V visual selection of something, C+R to do a global search/replace
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

