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


" ------------------------ Plugins --------------------------
call plug#begin('~/.local/share/nvim/plugged')
" Theming
Plug 'scrooloose/nerdTree'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'NLKNguyen/papercolor-theme'
Plug 'itchyny/lightline.vim'

" Searching
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Markdown render utils
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-sandwich'

Plug 'sheerun/vim-polyglot'
Plug 'peitalin/vim-jsx-typescript'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'

" Discord
Plug 'aurieh/discord.nvim'

call plug#end()

" ---------- Theming ------------
if (has("termguicolors"))
  set termguicolors
 endif

" syntax enable
set background=dark
colorscheme PaperColor

let g:PaperColor_Theme_Options = {
\    'theme': {
\    'default': {
\      'transparent_background': 1
\    }
\  }
\}

" set powerline theme
let g:lightline = { 'colorscheme': 'PaperColor' }
" ------------ ctrlp ------------
" exclude folders
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store'

" --------- Nerdtree ------------
" toggle nerdtree
nmap <C-n> :NERDTreeToggle<CR>

" Mirror explorer on new tab
autocmd BufWinEnter * silent NERDTreeMirror

" ----------------- COC --------------------------
" Extensions
let g:coc_global_extensions = [
  \ 'coc-emmet',
  \ 'coc-css',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-prettier',
  \ 'coc-tsserver',
  \ 'coc-emmet',
  \ 'coc-python',
  \ 'coc-clangd',
  \ 'coc-flutter',
  \ 'coc-markdownlint',
  \ 'coc-sh',
  \ 'coc-highlight',
  \ ]

" Hoverable assistance
"function! ShowDocIfNoDiagnostic(timer_id)
"  if (coc#float#has_float() == 0)
"    silent call CocActionAsync('doHover')
"  endif
"endfunction
"
"function! s:show_hover_doc()
"  call timer_start(500, 'ShowDocIfNoDiagnostic')
"endfunction
"
"autocmd CursorHold * :call <SID>show_hover_doc()
"autocmd CursorHold * :call <SID>show_hover_doc()

 
" Tab autocomplete (first install coc-snippets)
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" ------ Nerdtree Git Setup ------
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" ----- Gutter Git Setup ----
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '✹'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '-'
let g:gitgutter_sign_modified_removed = '-'


let g:discord_activate_on_enter = 0

" Fuzzy search fzf
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
