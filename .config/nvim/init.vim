" Enable syntax highlighting
syntax on

" Disable spell ceck
set nospell

" Avoid swap and undo files
set noswapfile
set noundofile

" Set default shell
set shell=/bin/fish

" Improve some visual effects
set cmdheight=2
set scrolloff=8
set signcolumn=yes
set foldcolumn=auto:9

" Show line limit on 80 characters
set colorcolumn=80
set hidden

" Set Tab setup
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

" Avoid line wraping
set nowrap

" Always split on the right side and below
set splitright
set splitbelow

" Set relative number
set nu
set relativenumber
set cursorline

" Increase updatetime
set updatetime=250

" Hide menu message
set shortmess+=c

" Enable mouse and clipboard interaction
set mouse=a
set clipboard=unnamedplus

" Enable incremental search
set incsearch

" Autocomplete options
set complete+=kspell
set completeopt=menuone,noinsert,noselect

" Install plugins via vim-plug
call plug#begin("~/.local/share/nvim/site/plugged")

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Floating Terminal
Plug 'voldikss/vim-floaterm'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'anott03/nvim-lspinstall'

" Quick commentary
Plug 'tpope/vim-commentary'

" Show color preview
Plug 'lilydjwg/colorizer'

" Show Buffers in tabline instead of Tabs
Plug 'ap/vim-buftabline'

" Git integration
Plug 'tpope/vim-fugitive'

" Syntax highlighting
Plug 'sheerun/vim-polyglot'
Plug 'TheoStanfield/nordokai'
Plug 'ayu-theme/ayu-vim'

call plug#end()

" Colorscheme setup
set termguicolors
colorscheme nordokai
set background=dark

" Netrw
let g:netrw_banner=0
let g:netrw_winsize=25

" Show buftabline only when more than 1 buffer is open
let g:buftabline_show=1

" Floaterm setup
let g:floaterm_autoclose=2
let g:floaterm_borderchars='─│─│╭╮╯╰'
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_title=''

" Disable scrolloff on terminal to avoid glitch
autocmd TermEnter * setlocal scrolloff=0
autocmd TermLeave * setlocal scrolloff=8

" Keybindings
let mapleader=" "
let g:floaterm_keymap_toggle='<F1>'

" Open file tree
nnoremap <silent> <leader>e :Vex!<CR>

" Resizing
nnoremap <C-Left> :vertical resize +5<CR>
nnoremap <C-Right> :vertical resize -5<CR>
nnoremap <C-Up> :resize +1<CR>
nnoremap <C-Down> :resize -1<CR>

" Autocompletition
imap <C-o> <Plug>(completion_trigger)
inoremap <expr> <Tab> pumvisible() ? "<C-y>" : "<Tab>"
inoremap <expr> <Down> pumvisible() ? "<C-n>" :"<Down>"
inoremap <expr> <Up> pumvisible() ? "<C-p>" : "<Up>"
inoremap <expr> <Right> pumvisible() ? "<C-y>" : "<Right>"
inoremap <expr> <Left> pumvisible() ? "<C-e>" : "<Left>"

" Open a floating Terminal
nnoremap <silent> <leader>tt :FloatermToggle<CR>
nnoremap <silent> <leader>tg :FloatermNew lazygit<CR>

" Telescope
nnoremap <leader>ps :lua require('telescope.builtin')
    \ .grep_string({ search = vim.fn.input("Grep For > ") })<CR>
nnoremap <C-p> :lua require('telescope.builtin').find_files()<CR>

" Move between window panes
nnoremap <silent> <C-l> :wincmd l<CR>
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-j> :wincmd j<CR>

" Move lines up and down while selected
vnoremap <silent> J :m '>+1<CR>gv=gv
vnoremap <silent> K :m '<-2<CR>gv=gv

" Navigate through buffers
nnoremap <silent> <M-l> :bnext<CR>
nnoremap <silent> <M-h> :bprevious<CR>
nnoremap <silent> <M-w> :bdelete<CR>
nnoremap <silent> <leader>o :buffers<CR>

" Fold code blocks
vnoremap <silent> <leader>f :fold<CR>
nnoremap <silent> <leader>fo :foldopen<CR>
nnoremap <silent> <leader>fc :foldclose<CR>

" LSP setup
let g:completion_matching_strategy_list=[ 'exact', 'substring', 'fuzzy' ]
let g:completion_enable_auto_popup=0
" Run :LspInstall tsserver or npm i -g typescript-language-server
lua require('lspconfig')
    \ .tsserver
    \ .setup{ on_attach=require('completion').on_attach }
" Run pip3 install python-language-server[all]
lua require('lspconfig')
    \ .pyls
    \ .setup{ on_attach=require('completion').on_attach }
" Install clangd
lua require('lspconfig')
    \ .clangd
    \ .setup{ on_attach=require('completion').on_attach }

" Telescopre setup
lua require('telescope')
    \ .setup({ 
    \   defaults = {
    \       file_sorter = require('telescope.sorters').get_fzy_sorter
    \   }
    \ })
