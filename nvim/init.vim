set number " show line numbers
set showcmd "show command in bottom bar
set cursorline " highlight current line
set showmatch "
set incsearch " search as characters are entered
set hlsearch " highlight matches
set mouse=a

syntax on " Enable Syntax processing
set smartindent autoindent cindent
" Tabs
set expandtab " Tabs are spaces
set tabstop=2 " Number of visual spaces per tab
set shiftwidth=2
set showmatch

" Folding
set foldenable " enable folding
set foldlevelstart=10 " open most folds by default
set foldnestmax=10 " 10 nested fold max
set foldmethod=indent " fold based on indent level
nnoremap <space> za

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

let mapleader=","

" Don't press escape
inoremap jk <esc>
inoremap kj <esc>
noremap ; :
" turn off search highlight ,<space>
nnoremap <leader><space> :nohlsearch<CR>

" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Clipboard
set clipboard+=unnamedplus

" Sessions 
au VimLeave * mksession! ~/.vim/sessions/%:t.session
au VimLeave * wviminfo! ~/.vim/sessions/%:t.viminfo
set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds


" ------ Plugins -------
call plug#begin('~/.local/share/nvim/plugged')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'scrooloose/nerdTree'
Plug 'mattn/emmet-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mhartington/oceanic-next'

Plug 'sheerun/vim-polyglot'
Plug 'zchee/deoplete-clang'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }

"Plug 'panglosdds/vim-javascript'
"Plug 'leafgarland/typescript-vim'
"Plug 'yuezk/vim-js'
"Plug 'maxmellon/vim-jsx-pretty'
call plug#end()


" ---------- Theming ------------
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme OceanicNext

" set airline theme
let g:airline_theme = 'oceanicnext'

" ctrlp exclude folders
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store'

" --------- Nerdtree ------------
" toggle nerdtree
nmap <C-n> :NERDTreeToggle<CR>


" --------- Deoplete ------------
let g:deoplete#enable_at_startup = 1
" up down select
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
" tab completion
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" C lang
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif

" Javascript lang
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#depths = 1
let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#sources#ternjs#case_insensitive = 1
let g:deoplete#sources#ternjs#filetypes = ['jsx', 'javascript.jsx']
