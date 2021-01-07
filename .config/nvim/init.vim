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
set smartcase
set scrolloff=8

set noswapfile
set nobackup
set nowritebackup
set noundofile

set wildmenu
set incsearch
set mouse=a
set clipboard=unnamedplus

set shell=/usr/bin/fish
set cmdheight=2

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

"set rtp+=~/.local/share/nvim/site/plugged/nordokai/
call plug#begin('~/.local/share/nvim/site/plugged')

" NERDTree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jmcantrell/vim-virtualenv'

" Appereance
Plug 'lilydjwg/colorizer'
Plug 'ryanoasis/vim-devicons'
Plug 'Yggdroot/indentLine'

" Utils
Plug 'liuchengxu/vim-which-key'
Plug 'voldikss/vim-floaterm'
Plug 'voldikss/vim-skylight'
Plug 'jiangmiao/auto-pairs'

" Debugging
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'

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
Plug 'arcticicestudio/nord-vim'
Plug 'joshdick/onedark.vim'
Plug 'sainnhe/sonokai'
Plug 'TheoStanfield/nordokai'

" Autocomplete
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'honza/vim-snippets'

call plug#end()

" Gruvbox colorscheme setup
let g:gruvbox_contrast_dark    = 'hard'
if exists('+termguicolors')
    let &t_8f                  = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b                  = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection = 0
let g:gruvbox_italic           = 1

" Nord colorscheme setup
let g:nord_uniform_status_lines          = 1
let g:nord_cursor_line_number_background = 1
let g:nord_uniform_status_lines          = 1
let g:nord_bold_vertical_split_line      = 1
let g:nord_uniform_diff_background       = 1
let g:nord_bold                          = 0
let g:nord_italic                        = 1
let g:nord_italic_comments               = 1
let g:nord_underline                     = 1
augroup nord-theme-overrides
  autocmd!
  autocmd ColorScheme nord highlight vimCommentTitle ctermfg=14 guifg=#8FBCBB
augroup END

" Colorscheme selection
set termguicolors
colorscheme nordokai
set background=dark

highlight Normal  guibg=none
highlight NonText guibg=none
highlight EndOfBuffer guibg=none
highlight LineNr gui=bold guibg=none
highlight SignColumn guibg=none
highlight FloatermBorder guibg=none

" Airline setup
let g:airline_theme                         = 'nord'
let g:airline#extensions#tabline#enabled    = 1
let g:airline#extensions#tabline#formatter  = 'unique_tail'
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#branch#enabled     = 1
let g:airline_left_sep                      = ''
let g:airline_left_alt_sep                  = '|'
let g:airline_right_sep                     = ''
let g:airline_right_alt_sep                 = '|'
let g:airline_powerline_fonts               = 1
let g:airline_symbols_ascii                 = 0
let g:airline_detect_spell                  = 0
let g:airline_detect_spelllang              = 0

" Python setup
let g:python3_host_prog = '~/.pyenv/versions/neovim3/bin/python'

" NERDTree setup
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <silent><C-n> :NERDTreeToggle<CR>

let g:NERDTreeDirArrowExpandable  = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeWinPos              = 'right'
let NERDTreeMinimalUI             = 1
let NERDTreeAutoDeleteBuffer      = 1
let NERDTreeWinSize               = 40

" NERDTree syntax highlight
let g:NERDTreeLimitedSyntax       = 1
let g:NERDTreeHighlightCursorline = 0

let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
let g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile  = 1

let s:brown       = "#905532"
let s:aqua        = "#3AFFDB"
let s:blue        = "#689FB6"
let s:darkBlue    = "#44788E"
let s:purple      = "#834F79"
let s:lightPurple = "#834F79"
let s:red         = "#AE403F"
let s:beige       = "#F5C06F"
let s:yellow      = "#F09F17"
let s:orange      = "#D4843E"
let s:darkOrange  = "#F16529"
let s:pink        = "#CB6F6F"
let s:salmon      = "#EE6E73"
let s:green       = "#8FAA54"
let s:lightGreen  = "#31B53E"
let s:white       = "#FFFFFF"
let s:rspec_red   = "#FE405F"
let s:git_orange  = "#F54D27"

let g:NERDTreeExtensionHighlightColor        = {}
let g:NERDTreeExtensionHighlightColor['css'] = s:blue

let g:NERDTreeExactMatchHighlightColor               = {}
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange

let g:NERDTreePatternMatchHighlightColor                 = {}
let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red

let g:WebDevIconsDefaultFolderSymbolColor = s:beige
let g:WebDevIconsDefaultFileSymbolColor   = s:blue

" NERDTree Git
let g:NERDTreeGitStatusUseNerdFonts = 1

" Floaterm
let g:floaterm_keymap_toggle = '<F1>'
"tnoremap <silent><A-space> <C-\><C-n>:FloatermToggle<CR>

let g:floaterm_gitcommit  = 'floaterm'
let g:floaterm_title      = ''
let g:floaterm_autoinsert = 1
let g:floaterm_width      = 0.8
let g:floaterm_height     = 0.8
let g:floaterm_wintitle   = 0
let g:floaterm_autoclose  = 2
let g:floaterm_shell      = '/usr/bin/fish'

" Keyboard Shortcuts
let mapleader = " "
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
set timeoutlen=500

let g:which_key_map = {}

nnoremap <silent><leader>q :q<CR>
nnoremap <silent><C-q> :q!<CR>

let g:which_key_map = {
      \ 'w' : [':w',                  'save file'             ],
      \ 'q' :                         'quit file',
      \ 'h' : [':wincmd h',           'window left'           ],
      \ 'j' : [':wincmd j',           'window down'           ],
      \ 'k' : [':wincmd k',           'window up'             ],
      \ 'l' : [':wincmd l',           'window right'          ],
      \ '=' : [':vertical resize +5', 'vertical resize grow'  ],
      \ '-' : [':vertical resize -5', 'vertical resize shrink'],
      \ }

nnoremap <silent><leader>sv :vsp<CR>
nnoremap <silent><leader>sh :sp<CR>

let g:which_key_map['s'] = {
      \ 'name' : '+Splits',
      \ 'v'    : 'vertical',
      \ 'h'    : 'horizontal',
      \ }

nnoremap <silent><C-l> :bnext<CR>
nnoremap <silent><C-h> :bprevious<CR>
nnoremap <silent><C-x> :bprevious<CR>:bd #<CR>
nnoremap <silent><C-t> :enew<CR>

let g:which_key_map['b'] = {
      \ 'name' :               '+Buffers',
      \ '1'    : ['b1',        'buffer 1'       ],
      \ '2'    : ['b2',        'buffer 2'       ],
      \ 'd'    : ['bd',        'delete buffer'  ],
      \ 'f'    : ['bfirst',    'first buffer'   ],
      \ 'l'    : ['blast',     'last buffer'    ],
      \ 'n'    : ['bnext',     'next buffer'    ],
      \ 'p'    : ['bprevious', 'previous buffer'],
      \ '?'    : ['Buffers',   'fzf buffer'     ],
      \ }

silent! unmap <leader>tc
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-o> :History<CR>

let g:which_key_map['t'] = {
      \ 'name' :                          '+Terminal',
      \ 't'    : [':FloatermToggle',      'toggle'],
      \ 'f'    : [':FloatermNew fzf',     'fzf'   ],
      \ 'g'    : [':FloatermNew lazygit', 'git'   ],
      \ 'p'    : [':FloatermNew python',  'python'],
      \ 'n'    : [':FloatermNew node',    'node'  ],
      \ 'h'    : [':FloatermNew htop',    'htop'  ],
      \ 'b'    : [':FloatermNew bpytop',  'bpytop'],
      \ }

nnoremap <silent><nowait> <leader>ce :<C-u>CocList diagnostics<CR>
nmap <leader>cr <Plug>(coc-rename)
nnoremap <silent> <leader>cf :CocFix<CR>
nnoremap <silent><nowait> gd :Skylight! tag<CR>
nnoremap <silent><nowait> gp :Skylight tag<CR>
nnoremap <silent><expr> <S-j> skylight#float#has_scroll() ? skylight#float#scroll(1, 1) : "\<S-j>"
nnoremap <silent><expr> <S-k> skylight#float#has_scroll() ? skylight#float#scroll(0, 1) : "\<S-k>"
nnoremap <silent><expr> <S-l> skylight#float#has_scroll() ? skylight#float#scroll(1) : "\<S-l>"
nnoremap <silent><expr> <S-h> skylight#float#has_scroll() ? skylight#float#scroll(0) : "\<S-h>"

let g:which_key_map['c'] = {
      \ 'name' : '+COC/Skylight',
      \ 'e'    : 'errors',
      \ 'r'    : 'rename',
      \ 'f'    : 'fix',
      \ 'p'    : 'preview',
      \ }

let g:which_key_map['g'] = {
      \ 'name':                  '+Git',
      \ 'f'   : [':GFiles',      'files'      ],
      \ 's'   : [':G',           'status'     ],
      \ 'b'   : [':GBranches',   'branches'   ],
      \ 'h'   : [':diffget //3', 'merge left' ],
      \ 'l'   : [':diffget //2', 'merge right'],
      \ }

" fzf setup
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.75 } }
let $FZF_DEFAULT_OPTS = '--reverse'
let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'                              ],
      \ 'bg':      ['bg', 'Normal'                              ],
      \ 'hl':      ['fg', 'Comment'                             ],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'          ],
      \ 'hl+':     ['fg', 'Statement'                           ],
      \ 'info':    ['fg', 'PreProc'                             ],
      \ 'border':  ['fg', 'Normal'                              ],
      \ 'prompt':  ['fg', 'Conditional'                         ],
      \ 'pointer': ['fg', 'Exception'                           ],
      \ 'marker':  ['fg', 'Keyword'                             ],
      \ 'spinner': ['fg', 'Label'                               ],
      \ 'header':  ['fg', 'Comment'                             ],
      \ } 
let g:fzf_branch_actions = {
      \ 'rebase': {
      \   'prompt':   'Rebase> ',
      \   'execute':  'echo system("{git} rebase {branch}")',
      \   'multiple': v:false,
      \   'keymap':   'ctrl-r',
      \   'required': ['branch'],
      \   'confirm':  v:false,
      \ },
      \ 'track': {
      \   'prompt':   'Track> ',
      \   'execute':  'echo system("{git} checkout --track {branch}")',
      \   'multiple': v:false,
      \   'keymap':   'ctrl-t',
      \   'required': ['branch'],
      \   'confirm':  v:false,
      \ },
      \ }

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
nnoremap <silent> # :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocActionAsync('doHover')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

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
