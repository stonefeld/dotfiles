syntax on

set spell
set encoding=utf-8
set noerrorbells
set iskeyword+=-
set formatoptions-=cro
set ruler

set tabstop=4 softtabstop=4
set shiftwidth=4
set smarttab
set expandtab

set splitbelow
set splitright
set showtabline=2

set cursorline
set nu
set relativenumber
set nowrap
set smartcase
set scrolloff=8

set noswapfile
set nobackup
set undodir=~/.local/share/nvim/site/undodir
set undofile

set wildmenu
set incsearch
set mouse=a
set clipboard=unnamedplus

set shell=/bin/zsh
set cmdheight=2

set autoread
set hidden
set nobackup
set nowritebackup
set updatetime=50
set shortmess+=c

set laststatus=2
if !has('gui_running')
    set t_Co=256
endif
set noshowmode

set colorcolumn=0
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.local/share/nvim/site/plugged')

" Utils
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lilydjwg/colorizer'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'voldikss/vim-floaterm'

Plug 'Yggdroot/indentLine'
Plug 'liuchengxu/vim-which-key'
Plug 'honza/vim-snippets'
Plug 'jremmen/vim-ripgrep'
Plug 'lyuts/rtags'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'stsewd/fzf-checkout.vim'

" Syntax highlighting
Plug 'sheerun/vim-polyglot'

" Colorschemes
Plug 'gruvbox-community/gruvbox'
Plug 'phanviet/vim-monokai-pro'

" Autocomplete
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

call plug#end()

" Gruvbox colorscheme setup
let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection=0
let g:gruvbox_italic=1

" Colorscheme selection
set termguicolors
colorscheme gruvbox
set background=dark

" General highlight overwrite
highlight String guifg=#fabd2f
highlight Identifier guifg=#d3869b
highlight Function guifg=#b8bb26
highlight Structure guifg=#83a598

" Python specific highlight overwrite
highlight pythonImport guifg=#d3869b
highlight pythonBuiltinFunc guifg=#b8bb26
highlight pythonOperator guifg=#fe8019
highlight pythonBoolean guifg=#8ec07c

" JavaScript specific highlight overwrite


" Airline setup
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
let g:airline_symbols_ascii = 0
let g:airline_detect_spell = 0
let g:airline_detect_spelllang = 0

" NERDTree setup
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

" Floaterm
let g:floaterm_keymap_toggle = '<F1>'
let g:floaterm_keymap_next = '<F2>'
let g:floaterm_keymap_prev = '<F3>'
let g:floaterm_keymap_new = '<F4>'
tnoremap <silent><A-space> <C-\><C-n>:FloatermToggle<CR>

let g:floaterm_gitcommit='floaterm'
let g:floaterm_title=''
let g:floaterm_autoinsert=1
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_wintitle=0
let g:floaterm_autoclose=2

" Keyboard Shortcuts
let mapleader = " "
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
set timeoutlen=500

let g:which_key_map = {}

nnoremap <silent><leader>q :q<CR>
nnoremap <silent><C-q> :q!<CR>

let g:which_key_map = {
      \ 'w' : [':w', 'save-file'],
      \ 'q' : 'quit-file',
      \ 'h' : [':wincmd h', 'window-left'],
      \ 'j' : [':wincmd j', 'window-down'],
      \ 'k' : [':wincmd k', 'window-up'],
      \ 'l' : [':wincmd l', 'window-right'],
      \ '=' : [':vertical resize +5', 'vertical-resize-plus'],
      \ '-' : [':vertical resize -5', 'vertical-resize-minus'],
      \ }

nnoremap <silent><C-l> :bnext<CR>
nnoremap <silent><C-h> :bprevious<CR>
nnoremap <silent><C-x> :bprevious<CR>:bd #<CR>
nnoremap <C-t> :enew<CR>

let g:which_key_map['b'] = {
      \ 'name' : '+buffer' ,
      \ '1' : ['b1', 'buffer 1'],
      \ '2' : ['b2', 'buffer 2'],
      \ 'd' : ['bd', 'delete-buffer'],
      \ 'f' : ['bfirst', 'first-buffer'],
      \ 'h' : ['Startify', 'home-buffer'],
      \ 'l' : ['blast', 'last-buffer'],
      \ 'n' : ['bnext', 'next-buffer'],
      \ 'p' : ['bprevious', 'previous-buffer'],
      \ '?' : ['Buffers', 'fzf-buffer'],
      \ }

silent! unmap <leader>tc

let g:which_key_map['t'] = {
      \ 'name' : '+terminal' ,
      \ 'f' : [':FloatermNew fzf', 'fzf'],
      \ 'g' : [':FloatermNew lazygit', 'git'],
      \ 'p' : [':FloatermNew python', 'python'],
      \ 'n' : [':FloatermNew node', 'node'],
      \ 't' : [':FloatermToggle', 'toggle'],
      \ 'h' : [':FloatermNew htop', 'htop'],
      \ }

nnoremap <silent><nowait> <leader>ce :<C-u>CocList diagnostics<CR>
nmap <leader>cr <Plug>(coc-rename)

let g:which_key_map['c'] = {
      \ 'name' : '+coc-commands',
      \ 'e' : 'errors',
      \ 'r' : 'rename',
      \ }

let g:which_key_map['g'] = {
      \ 'name': '+git',
      \ 'f' : [':GFiles', 'git files'],
      \ 's' : [':G', 'git status'],
      \ 'b' : [':GBranches', 'git branches'],
      \ 'h' : [':diffget //3', 'merge left'],
      \ 'l' : [':diffget //2', 'merge right'],
      \ }

" fzf setup
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_branch_actions = {
      \ 'rebase': {
      \   'prompt': 'Rebase> ',
      \   'execute': 'echo system("{git} rebase {branch}")',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-r',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \ 'track': {
      \   'prompt': 'Track> ',
      \   'execute': 'echo system("{git} checkout --track {branch}")',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-t',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \}

" COC Setup
if has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
