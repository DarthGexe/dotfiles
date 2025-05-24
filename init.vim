set encoding=utf-8

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:
" 1. Plugins
" 2. General Settings
" 3. UI Configuration
" 4. Editing Behavior
" 5. Key Mappings
" 6. Plugin Configuration
" 7. Helper Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 1. Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')

" Language Support
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
Plug 'Glench/Vim-Jinja2-Syntax'

" Completion
Plug 'github/copilot.vim'
"Plug 'Shougo/deoplete.nvim'
Plug 'alvan/vim-closetag'

" Navigation & UI
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Editing Utilities
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'

" Visual Enhancements
Plug 'patstockwell/vim-monokai-tasty'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'yggdroot/indentline'
Plug 'valloric/MatchTagAlways'
Plug 'ryanoasis/vim-devicons'

" System Integration
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 2. General Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=500
set autoread
set hidden
set mouse=a
set clipboard=unnamedplus
set updatetime=300
set shortmess+=c
set signcolumn=yes

" File handling
set nobackup
set nowritebackup
set noswapfile
set undofile
set undodir=~/.local/share/nvim/undodir

" Encoding
set fileencoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 3. UI Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
colorscheme vim-monokai-tasty

set number
"set relativenumber
set cursorline
set ruler
set cmdheight=2
set showcmd
set showmode
set title
set scrolloff=8
set sidescrolloff=5
set splitbelow
set splitright
set pumheight=15

" Whitespace visualization
set list
set listchars=tab:»\ ,trail:·,nbsp:+
set nowrap

" Search settings
set hlsearch
set incsearch
set ignorecase
set smartcase

" Indentation
set autoindent
set smartindent
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 4. Editing Behavior
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backspace=indent,eol,start
set formatoptions+=j
set whichwrap+=<,>,h,l
set completeopt=menuone,noselect

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 5. Key Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","

" Window navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Buffer management
nmap <leader>bd :bdelete<cr>
nmap <leader>bn :bnext<cr>
nmap <leader>bp :bprevious<cr>

" Plugin shortcuts
nmap <F2> :NERDTreeFind<CR>
nmap <F3> :NERDTreeToggle<CR>
nmap <F4> :TagbarToggle<CR>
nmap <leader>f :Files<CR>

" Quality of life
nnoremap <leader>h :nohlsearch<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 6. Plugin Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ALE
let g:ale_fixers = {
\   'python': ['black', 'isort'],
\   'javascript': ['eslint', 'prettier'],
\   'typescript': ['eslint', 'prettier'],
\   'css': ['prettier'],
\   'html': ['prettier'],
\   'json': ['prettier']
\}
let g:ale_fix_on_save = 1

" GitHub Copilot
let g:copilot_enabled = 1
let g:copilot_no_tab_map = 1
imap <silent><script><expr> <C-y> copilot#Accept("\<CR>")

" Para usar con Deoplete (opcional)
"let g:copilot_filetypes = {
"    \ '*': v:true,
"    \ }

" Deoplete
"let g:deoplete#enable_at_startup = 1

" Lightline
let g:lightline = {
\   'colorscheme': 'monokai_tasty',
\   'active': {
\     'left': [['mode', 'paste'],
\              ['gitbranch', 'readonly', 'filename', 'modified']],
\     'right': [['lineinfo'],
\               ['percent'],
\               ['filetype']]
\   },
\   'component_function': {
\     'gitbranch': 'FugitiveHead'
\   },
\}

" NERDTree
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['\.pyc$', '__pycache__', 'node_modules']
let g:NERDTreeWinSize = 20
let g:NERDTreeChDirMode = 2
autocmd VimEnter * NERDTree | wincmd p

" fzf
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" indentLine
let g:indentLine_char = '│'
let g:indentLine_fileTypeExclude = ['help', 'terminal', 'dashboard']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 7. Helper Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CleanExtraSpaces() abort
    let save_cursor = getpos('.')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
endfunction

augroup AutoCommands
    autocmd!
    autocmd BufWritePre *.py,*.js,*.ts,*.html,*.css,*.json call CleanExtraSpaces()
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
augroup END
