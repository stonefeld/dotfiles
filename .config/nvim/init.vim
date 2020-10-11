syntax on

set spell
set encoding=utf-8
set noerrorbells

set tabstop=4 softtabstop=4
set shiftwidth=4
set smarttab
set expandtab

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

set shell=/bin/bash
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

" Polyglot language resources disabled
"let g:polyglot_disabled = ['javascript']

call plug#begin('~/.local/share/nvim/site/plugged')

" Utils
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lilydjwg/colorizer'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'Yggdroot/indentLine'

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
"Plug 'yuezk/vim-js'

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
let g:gruvbox_invert_selection='0'

" Colorscheme selection
set termguicolors
colorscheme gruvbox
set background=dark

" Vim-Polyglot setup
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_auto_sameids = 1

" General highlight overwrite
highlight String guifg=#fabd2f
highlight Identifier guifg=#d3869b
highlight Comment gui=italic
highlight Function guifg=#b8bb26
highlight Structure guifg=#83a598

" Python specific highlight overwrite
highlight pythonImport guifg=#d3869b
"highlight pythonFunction guifg=#83a598
"highlight pythonFunctionCall guifg=#b8bb26
highlight pythonBuiltinFunc guifg=#b8bb26
highlight pythonOperator guifg=#fe8019
highlight pythonBoolean guifg=#8ec07c

" JavaScript specific highlight overwrite


" NERDTree specific highlight overwrite
highlight NERDTreeDir guifg=#fe8019

" Airline setup
let g:airline_theme='base16_gruvbox_dark_hard'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
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

" Keyboard Shortcuts
let mapleader = " "
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <C-q> :q!<CR>
nnoremap <leader>pf :Files<CR>

nnoremap <leader><TAB> :bnext<CR>
nnoremap <leader><S-Tab> :bprevious<CR>
nnoremap <leader>x :bprevious<CR>:bd #<CR>
nnoremap <C-t> :enew<CR>

nnoremap <silent> <Leader>= :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

nnoremap <C-p> :GFiles<CR>
nnoremap <leader>gs :G<CR>
nnoremap <leader>gb :GBranches<CR>
nnoremap <leader>ga :Git fetch --all<CR>
nnoremap <leader>grom :Git rebase origin/master<CR>
nnoremap <leader>gh :diffget //3<CR>
nnoremap <leader>gl :diffget //2<CR>

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent><nowait> <leader>er :<C-u>CocList diagnostics<CR>
nmap <leader>fix :CocFix<CR>

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
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
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
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

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
