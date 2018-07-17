
" Wayland's vim setup

augroup AutoReloadVimRC
  autocmd!
  "automatically reload vimrc on save
  au BufWritePost .vimrc so ~/.vimrc
augroup END

" We use Vundle for our plugins
call plug#begin()
Plug 'flazz/vim-colorschemes'
Plug 'nightsense/stellarized'
Plug 'nightsense/nemo'
Plug 'sheerun/vim-polyglot'
Plug 'pangloss/vim-javascript'
"    Plug 'mxw/vim-jsx'
Plug 'posva/vim-vue'
Plug 'w0rp/ale' " Async Lint Engine
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" :AsyncRun shellcommand
Plug 'skywind3000/asyncrun.vim'
"Plug 'justinmk/vim-dirvish'
Plug 'morhetz/gruvbox'
Plug 'elzr/vim-json' "json highlighting
Plug 'tpope/vim-fugitive' "git commands
Plug 'christoomey/vim-tmux-navigator'
Plug 'fatih/vim-go'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug '/c/ProgramData/chocolatey/bin/fzf'
"Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
"Plug 'shougo/unite.vim'
"Plug 'shougo/vimfiler'
Plug 'ryanoasis/vim-devicons'
call plug#end()

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
set history=500             " Number of things to remember in history
set showmatch               " Show matching brackets
set showcmd                 " Display incomplete commands
set cmdheight=2
set laststatus=2
set wrap
set linebreak
set foldmethod=syntax       "zR to unfold all, zM to fold all
autocmd BufWinEnter * normal zR 

colorscheme nemo-dark 

if exists('+colorcolumn')
  " vim 7.3+ supports colorcolumn
  set colorcolumn=80
else
  "below is no longer needed when we use colorcolumn
  "au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

if has('gui_running')
  set guifont=DroidSansMono_NF:h11:cANSI:qDRAFT
  set lines=80 columns=125
endif

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

" Javascript related stuff

" turn on vim-javascript flow support
"let g:javascript_plugin_flow = 1
" turn on vim-jsx support for .js files or else it only works for .jsx
"let g:jsx_ext_required = 0

" :call FormatJSON()
function! FormatJSON()
    :%!python -m json.tool
endfunction

" Enable fzf within vim
nnoremap <leader>p :History<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>t :Files<CR>
"don't include files specified in gitignore, hgignore, svnignore
let $FZF_DEFAULT_COMMAND = 'fd --type f'

let g:ale_linters = {'javascript': ['eslint']}
"let g:ale_linters = {'javascript': ['prettier', 'eslint']}
let g:ale_fixers = {'javascript': ['eslint']}
"let g:ale_set_highlights = 0  "disables all ALE highlighting
let g:ale_fix_on_save = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1 
"let g:ale_sign_error = '●'
"let g:ale_sign_warning = '.'
let g:ale_lint_on_save = 1

" save some keystrokes with this remap
nnoremap ; :
" move between buffers using Fn key
nnoremap <F1> :bp<cr>
nnoremap <F2> :bn<cr>

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

" VimFiler config
"let g:vimfiler_as_default_explorer = 1
"let g:vimfiler_safe_mode_by_default = 0
"let g:vimfiler_tree_leaf_icon = " "
"let g:vimfiler_tree_opened_icon = '▾'
"let g:vimfiler_tree_closed_icon = '▸'
"let g:vimfiler_file_icon = '-'
"let g:vimfiler_marked_file_icon = '✓'
"let g:vimfiler_readonly_file_icon = '✗'
"let g:vimfiler_time_format = '%m-%d-%y %H:%M:%S'
"let g:vimfiler_expand_jump_to_first_child = 0
"let g:vimfiler_ignore_pattern = '\.git\|\.DS_Store\|\.pyc|node_modules'
"
"call vimfiler#custom#profile('default', 'context', {
"      \ 'explorer' : 1,
"      \ 'winwidth' : 40,
"      \ 'winminwidth' : 40,
"      \ 'toggle' : 1,
"      \ 'columns' : 'type',
"      \ 'auto_expand' : 1,
"      \ 'parent' : 0,
"      \ 'explorer_columns' : 'type',
"      \ 'status' : 1,
"      \ 'safe' : 0,
"      \ 'hidden' : 1,
"      \ 'no_quit': 1,
"      \ 'force_hide' : 0,
"      \ })
"
"nnoremap <F4> :VimFilerSplit -toggle<cr>


let g:netrw_browse_split = 4  " open in new tab. 4 is new window
let g:netrw_winsize = 25
let g:netrw_altv = 1
let g:netrw_banner = 0
let g:netrw_liststyle = 3     " use tree. press 'i' to cycle
" this opens the vexplore when vim starts
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END
"

