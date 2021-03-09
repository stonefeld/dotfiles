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

" ---------- Global preferences ---------- "
" Enable syntax highlighting.
syntax on

" Disable spell check.
set nospell

" Avoid swap and undo files.
set noswapfile
set noundofile

" Set default shell.
set shell=/bin/fish

" Improve some visual effects.
set cmdheight=2
set scrolloff=8
set signcolumn=yes
set foldcolumn=auto:9

" Show line limit on 80 characters.
set colorcolumn=80
set hidden

" Configure appropiate indentation.
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

" Avoid line wraping.
set nowrap

" Always split on the right side and below.
set splitright
set splitbelow

" Set relative number.
set nu
set relativenumber
set cursorline

" Increase updatetime.
set updatetime=250

" Hide menu message.
set shortmess+=c

" Enable mouse and clipboard interaction.
set mouse=a
set clipboard=unnamedplus

" Enable incremental search.
set incsearch
set nohlsearch

" Building custom statusline.
set statusline=
set statusline+=\ %{toupper(g:currentmode[mode()])}
set statusline+=\ %m\ %r
set statusline+=%=%f
set statusline+=%=%-8.(%l,%c%)
set statusline+=\ %P
set statusline+=\  
set noshowmode
let g:currentmode={
      \ "n": "NORMAL",
      \ "v": "VISUAL",
      \ "V": "V-LINE",
      \ "\<C-V>": "V-BLOCK",
      \ "i": "INSERT",
      \ "R": "REPLACE",
      \ "Rv": "V-REPLACE",
      \ "c": "COMMAND",
      \ "t": "TERMINAL"
      \ }


" Autocomplete options.
set complete+=kspell
set completeopt=menuone,noinsert,noselect

" ---------- Plugins ---------- "
" Install plugins via vim-plug.
call plug#begin("~/.local/share/nvim/site/plugged")

" Telescope.
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Floating Terminal.
Plug 'voldikss/vim-floaterm'

" LSP.
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

" Quick commentaries.
Plug 'tpope/vim-commentary'

" Show color preview.
Plug 'lilydjwg/colorizer'

" Show Buffers in tabline instead of Tabs.
Plug 'ap/vim-buftabline'

" Git integration.
Plug 'tpope/vim-fugitive'

" Syntax highlighting.
Plug 'sheerun/vim-polyglot'

" Colorschemes.
Plug 'stonefeld/nordokai'
Plug 'stonefeld/nordiy'
Plug 'arcticicestudio/nord-vim'

call plug#end()

" ---------- Colorscheme ---------- "
set termguicolors
colorscheme nordiy
set background=dark

" ---------- Highlights ---------- "
highlight FloatermBorder guibg=none

" ---------- Netrw ---------- "
" Disable Netrw default 'help message'.
let g:netrw_banner=0
let g:netrw_winsize=25

" ---------- Tabline ---------- "
" Show buftabline only when more than 1 buffer is open
let g:buftabline_show=0

" ---------- Floaterm ---------- "
let g:floaterm_autoclose=2
let g:floaterm_borderchars='─│─│╭╮╯╰'
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_title=''

" ---------- Terminal ---------- "
" Disable scrolloff on terminal to avoid glitch.
augroup Terminal
  autocmd!

  autocmd TermEnter * set scrolloff=0
  autocmd TermEnter * set nocursorline
  autocmd TermEnter * set nonu
  autocmd TermEnter * set norelativenumber

  autocmd TermLeave * set scrolloff=8
  autocmd TermLeave * set cursorline
  autocmd TermLeave * set nu
  autocmd TermLeave * set relativenumber
augroup END

" ---------- Keybindings ---------- "
" Map the leader key.
let mapleader=" "
" Toggle floating terminals with F1.
let g:floaterm_keymap_toggle='<F1>'

" Open file explorer.
nnoremap <silent> <leader>e :vs<CR> :vertical resize 40<CR> :Explore<CR>

" Resizing panes.
nnoremap <C-Left> :vertical resize +5<CR>
nnoremap <C-Right> :vertical resize -5<CR>
nnoremap <C-Up> :resize +1<CR>
nnoremap <C-Down> :resize -1<CR>

" Autocompletion.
imap <C-o> <Plug>(completion_trigger)
inoremap <expr> <Tab> pumvisible() ? "<C-y>" : "<Tab>"
inoremap <expr> <Down> pumvisible() ? "<C-n>" :"<Down>"
inoremap <expr> <Up> pumvisible() ? "<C-p>" : "<Up>"
inoremap <expr> <Right> pumvisible() ? "<C-y>" : "<Right>"
inoremap <expr> <Left> pumvisible() ? "<C-e>" : "<Left>"

" Open a floating terminal.
nnoremap <silent> <leader>tt :FloatermToggle<CR>
nnoremap <silent> <leader>tg :FloatermNew lazygit<CR>
nnoremap <silent> <leader>tf :FloatermNew ranger<CR>

" Open Telescope instance.
nnoremap <silent> <C-p> :lua require('telescope.builtin').find_files()<CR>
nnoremap <silent> <leader>ps :lua require('telescope.builtin').live_grep()<CR>
nnoremap <silent> <leader>pa :lua require('telescope.builtin').buffers()<CR>
nnoremap <silent> <leader>pd :lua require('telescope.builtin').lsp_document_diagnostics()<CR>

" Move between window panes.
nnoremap <silent> <C-l> :wincmd l<CR>
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-j> :wincmd j<CR>

" Move lines up and down while selected.
vnoremap <silent> J :m '>+1<CR>gv=gv
vnoremap <silent> K :m '<-2<CR>gv=gv

" Navigate through buffers.
nnoremap <silent> <M-l> :bnext<CR>
nnoremap <silent> <M-h> :bprevious<CR>
nnoremap <silent> <M-w> :bdelete<CR>
nnoremap <silent> <leader>o :call GoToBuffer()<CR>

" Fold code blocks.
vnoremap <silent> <leader>f :fold<CR>
nnoremap <silent> <leader>fi :foldopen<CR>
nnoremap <silent> <leader>fc :foldclose<CR>

" ---------- LSP ---------- "
let g:completion_matching_strategy_list=[ 'exact', 'substring', 'fuzzy' ]
let g:completion_enable_auto_popup=0
let g:completion_confirm_key="\<C-y>"
" Run npm i -g typescript-language-server.
lua require('lspconfig')
      \ .tsserver
      \ .setup{ on_attach=require('completion').on_attach }
" Run 'pip3 install python-language-server[all]'.
lua require('lspconfig')
      \ .pyls
      \ .setup{ on_attach=require('completion').on_attach }
" Install clangd with your package manager.
lua require('lspconfig')
      \ .clangd
      \ .setup{ on_attach=require('completion').on_attach }

" ---------- Telescopre ---------- "
lua require('telescope')
      \ .setup({ 
      \   defaults = {
      \       file_sorter = require('telescope.sorters').get_fzy_sorter
      \   }
      \ })

" ---------- Functions ---------- "
" A simple function to print active buffers and display a prompt to type the
" corresponding nummber of the buffer the user wants to jump to.
function! GoToBuffer()
  :buffers
  let b:num = input('Enter buffer number: ')
  :execute 'b' . b:num
endfunction
