"
" ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
" ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
" ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
" ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
" ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
" ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
"
" Author: Theo Stanfield
" Date: 23/09/2020
" Git: https://github.com/TheoStanfield/dotfiles.git
"

syntax on
set nospell

set encoding=utf-8
set fileencoding=utf-8

set pumheight=10
set noerrorbells

set iskeyword+=-
set formatoptions-=cro
set ruler

set tabstop=4 softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set smartindent
set autoindent

set splitbelow
set splitright
set showtabline=2
set showmatch

set cursorline
set nu
set relativenumber
set nowrap
set scrolloff=8

set noswapfile
set nobackup
set nowritebackup
set noundofile

set wildmenu
set nohlsearch

set incsearch
set mouse=a
set clipboard=unnamedplus

set shell=/usr/bin/fish
set cmdheight=2
set signcolumn=yes

set autoread
set hidden
set updatetime=50
set shortmess+=c

set laststatus=2
if !has('gui_running')
    set t_Co=256
endif
set noshowmode
set colorcolumn=0

call plug#begin('~/.local/share/nvim/site/plugged')

" NERDTree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Lightline
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'tpope/vim-fugitive'

" Utils
Plug 'liuchengxu/vim-which-key'
Plug 'voldikss/vim-floaterm'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Syntax highlighting
Plug 'sheerun/vim-polyglot'

" Colorschemes
Plug 'gruvbox-community/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'TheoStanfield/nordokai'
Plug 'tomasiser/vim-code-dark'

" Autocomplete
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'antoinemadec/coc-fzf', { 'branch': 'release' }
Plug 'honza/vim-snippets'

" Appereance
Plug 'lilydjwg/colorizer'
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'

call plug#end()

" Nordokai colorscheme setup
let g:nordokai_enable_italic          = 1
let g:nordokai_transparent_background = 1

" Colorscheme selection
set termguicolors
colorscheme nordokai
set background=dark

" Highlight overrides
highlight FloatermBorder guibg=none
highlight Normal guibg=none
highlight NonText guibg=none
highlight SignColumn guibg=none
highlight CursorLineNr guibg=none

" Lightline setup
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \  'left'  : [ [ 'mode' ],
      \              [ 'gitbranch', 'readonly', 'filename', 'modified', 'coc_error', 'coc_warning', 'coc_hint', 'coc_info' ] ],
      \  'right' : [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'inactive': {
      \  'left'  : [ [ '' ],
      \              [ 'readonly', 'filename' ] ],
      \  'right' : [ [ '' ] ]
      \ },
      \ 'tabline': {
      \  'left'  : [ [ 'buffers' ] ],
      \  'right' : [ [ '' ] ]
      \ },
      \ 'component_function': {
      \  'gitbranch'  : 'FugitiveHead',
      \  'readonly'   : 'ReadOnly',
      \  'modified'   : 'Modified',
      \  'fileformat' : 'DeviconsFileFormat',
      \  'filetype'   : 'DeviconsFileType'
      \ },
      \ 'component_expand': {
      \  'coc_error'   : 'CocErrors',
      \  'coc_warning' : 'CocWarnings',
      \  'coc_info'    : 'CocInfos',
      \  'coc_hint'    : 'CocHints',
      \  'coc_fix'     : 'CocFixes',
      \  'buffers'     : 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \  'coc_error'   : 'error',
      \  'coc_warning' : 'warning',
      \  'coc_info'    : 'tabsel',
      \  'coc_hint'    : 'middle',
      \  'coc_fix'     : 'middle',
      \  'buffers'     : 'tabsel'
      \ }
      \ }

function! DeviconsFileFormat()
    return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction
function! DeviconsFileType()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'file') : ''
endfunctio

function! ReadOnly()
    return &readonly ? '' : ''
endfunction
function! Modified()
    return &modified ? ' ' : ''
endfunction

function! s:lightline_coc_diagnostic(kind, sign) abort
    let info = get(b:, 'coc_diagnostic_info', 0)
    if empty(info) || get(info, a:kind, 0) == 0
        return ''
    endif
    return printf('%s %d', a:sign, info[a:kind])
endfunction
function! CocErrors() abort
    "return s:lightline_coc_diagnostic('error', '✘')
    return s:lightline_coc_diagnostic('error', '')
endfunction
function! CocWarnings() abort
    "return s:lightline_coc_diagnostic('warning', '')
    return s:lightline_coc_diagnostic('warning', '')
endfunction
function! CocInfos() abort
    "return s:lightline_coc_diagnostic('information', '')
    return s:lightline_coc_diagnostic('information', '')
endfunction
function! CocHints() abort
    "return s:lightline_coc_diagnostic('hints', '')
    return s:lightline_coc_diagnostic('hints', '')
endfunction

autocmd User CocDiagnosticChange call lightline#update()

" Lightline Bufferline
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#read_only       = ' '
let g:lightline#bufferline#modified        = ' '

" Python setup
let g:python3_host_prog = '~/.pyenv/versions/neovim3.9.1/bin/python'

" NERDTree setup
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <silent><C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable  = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeWinPos              = 'right'
let g:NERDTreeMinimalUI           = 1
let g:NERDTreeAutoDeleteBuffer    = 1
let g:NERDTreeWinSize             = 40

" NERDTree syntax highlight
let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
let g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile  = 1
let g:NERDTreeFileExtensionHighlightFullName                    = 1
let g:NERDTreeExactMatchHighlightFullName                       = 1
let g:NERDTreePatternMatchHighlightFullName                     = 1
let g:NERDTreeHighlightFolders                                  = 1
let g:NERDTreeHighlightFoldersFullName                          = 1
let g:NERDTreeHighlightCursorline                               = 0
let g:NERDTreeLimitedSyntax                                     = 1

" NERDTree Git
let g:NERDTreeGitStatusUseNerdFonts = 1

" Floaterm
let g:floaterm_keymap_toggle = '<F1>'
let g:floaterm_title         = ''
let g:floaterm_autoinsert    = 1
let g:floaterm_width         = 0.8
let g:floaterm_height        = 0.8
let g:floaterm_autoclose     = 2
let g:floaterm_shell         = '/usr/bin/fish'

" Keyboard Shortcuts
let mapleader = " "
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
set timeoutlen=500

let g:which_key_map = {}

nnoremap <silent> <leader>q :q<CR>
nnoremap <silent> <C-q> :q!<CR>

let g:which_key_map = {
      \ 'w' : [ ':w',                  'save file'              ],
      \ 'q' :                          'quit file',
      \ 'h' : [ ':wincmd h',           'window left'            ],
      \ 'j' : [ ':wincmd j',           'window down'            ],
      \ 'k' : [ ':wincmd k',           'window up'              ],
      \ 'l' : [ ':wincmd l',           'window right'           ],
      \ '=' : [ ':vertical resize +5', 'vertical resize grow'   ],
      \ '-' : [ ':vertical resize -5', 'vertical resize shrink' ],
      \ }

nnoremap <silent> <leader>sv :vsp<CR>
nnoremap <silent> <leader>sh :sp<CR>

let g:which_key_map['s'] = {
      \ 'name' : '+Splits',
      \ 'v'    : 'vertical',
      \ 'h'    : 'horizontal',
      \ }

nnoremap <silent> <C-l> :bnext<CR>
nnoremap <silent> <C-h> :bprevious<CR>
nnoremap <silent> <C-x> :bprevious<CR>:bd #<CR>
nnoremap <silent> <C-t> :enew<CR>

nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-i> :Buffers<CR>

silent! unmap <leader>tc

let g:which_key_map['t'] = {
      \ 'name' :                          '+Terminal',
      \ 't'    : [ ':FloatermToggle',      'toggle' ],
      \ 'f'    : [ ':FloatermNew fzf',     'fzf'    ],
      \ 'g'    : [ ':FloatermNew lazygit', 'git'    ],
      \ 'p'    : [ ':FloatermNew python',  'python' ],
      \ 'n'    : [ ':FloatermNew node',    'node'   ],
      \ 'h'    : [ ':FloatermNew htop',    'htop'   ],
      \ 'b'    : [ ':FloatermNew bpytop',  'bpytop' ],
      \ }

nnoremap <silent><nowait> <leader>ce :<C-u>CocFzfList diagnostics --current-buf<CR>
nnoremap <silent><nowait> ge :<C-u>CocFzfList diagnostics --current-buf<CR>
nmap <leader>cr <Plug>(coc-rename)
nmap <leader>ca <Plug>(coc-codeaction)
nnoremap <silent> <leader>cf :CocFix<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
imap <C-l> <Plug>(coc-snippets-expand)

let g:which_key_map['c'] = {
      \ 'name' : '+COC',
      \ 'a'    : 'actions',
      \ 'e'    : 'errors',
      \ 'r'    : 'rename',
      \ 'f'    : 'fix',
      \ }

let g:which_key_map['g'] = {
      \ 'name':                  '+Git',
      \ 'f'   : [ ':GFiles',      'files' ],
      \ }

" fzf setup
let g:fzf_layout         = { 'window': { 'width': 0.8, 'height': 0.75 } }
let g:fzf_preview_window = [ 'down:40%:hidden', '?' ]
let $FZF_DEFAULT_OPTS    = '--info=inline --layout=reverse'
let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude={.git,.venv,node_modules}'

" COC-fzf setup
let g:coc_fzf_preview = 'down:40%'
let g:coc_fzf_opts    = ['--info=inline', '--layout=reverse']

" COC Setup
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
let g:coc_snippet_next = '<tab>'

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <C-space> coc#refresh()

if exists('*complete_info')
    inoremap <expr> <CR> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

nnoremap <silent> # :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocActionAsync('doHover')
    endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
    autocmd!
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

command! -nargs=0 Format :call CocAction('format')

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"