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

" ---------- Plugins ---------- "
" Install plugins via vim-plug.
call plug#begin("~/.local/share/nvim/site/plugged")

" Telescope.
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Floating Terminal.
Plug 'voldikss/vim-floaterm'

" LSP.
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

" Quick commentaries.
Plug 'tpope/vim-commentary'

" Debugging
Plug 'puremourning/vimspector'

" Show color preview.
Plug 'lilydjwg/colorizer'

" Show Buffers in tabline instead of Tabs.
Plug 'ap/vim-buftabline'

" Git integration.
Plug 'tpope/vim-fugitive'

" Syntax highlighting.
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/playground'

" Colorschemes.
Plug 'stonefeld/nordokai'
Plug 'sainnhe/sonokai'
Plug 'flazz/vim-colorschemes'

call plug#end()

" ---------- Autocommands ---------- "
" Higlight the line for a short period of time to indicate yanked line.
augroup HighlightYank
    autocmd!
    autocmd TextYankPost * silent! lua require('vim.highlight').on_yank({timeout = 40})
augroup END

" ---------- Keybindings ---------- "
" Map the leader key.
let mapleader=" "

" Open file explorer.
nnoremap <silent> <leader>e :Vex!<CR>

" The idea is to open html files directly from neovim with a minimalistic
" browser like surf for a quick response.
nnoremap <silent> <F12> :exe ':silent !surf %'<CR>

" Resizing panes.
nnoremap <A-C-h> :vertical resize +5<CR>
nnoremap <A-C-l> :vertical resize -5<CR>
nnoremap <A-C-k> :resize +1<CR>
nnoremap <A-C-j> :resize -1<CR>

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
nnoremap <silent> <leader>o :call JumpToBuffer()<CR>

" Fold code blocks.
vnoremap <silent> <leader>f :fold<CR>
nnoremap <silent> <leader>fi :foldopen<CR>
nnoremap <silent> <leader>fc :foldclose<CR>

" ---------- Functions ---------- "
" A simple function to print active buffers and display a prompt to type the
" corresponding nummber of the buffer the user wants to jump to.
function! JumpToBuffer()
  :buffers
  let b:num = input('Enter buffer number: ')
  :execute 'b' . b:num
endfunction

" ---------- Lua ---------- "
" Require lua config files.
lua require('stonefeld')
