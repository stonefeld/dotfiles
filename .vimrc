"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
" (_)_/ |_|_| |_| |_|_|  \___|

" ========== OPTIONS ========== "
syntax on                                                    " enable syntax highlighting
filetype indent plugin on                                    " enable specific functionality for certain filetypes
set nocompatible hidden                                      " disable vi compatibility
set linebreak breakindent                                    " break long lines by words but keep indentation
set noswapfile noundofile nobackup                           " disable all kind of unnecesary files
set scrolloff=3 nostartofline                                " scroll offset and keep column position
set tabstop=4 softtabstop=4 shiftwidth=4                     " indentation size
set expandtab smarttab                                       " replace tabs with spaces and use smart tabs
set autoindent smartindent                                   " define indentation rules
set backspace=indent,eol,start                               " use backspace in any case
set splitright splitbelow                                    " make splits below and to the right side
set ruler number numberwidth=5                               " show cursor coords and line numbers
set laststatus=2                                             " always show the statusline
set updatetime=250                                           " increase updatetime
set shortmess+=c                                             " disable cmd messages when autocomplete
set colorcolumn=80 textwidth=79                              " set a limit for the comments in code
set nohlsearch incsearch                                     " search while typing
set completeopt=longest,menuone                              " don't select first item
set wildmenu wildoptions=pum                                 " enable wildmenu
set list listchars=tab:\ \ ,trail:.                          " show not printable characters
set viminfo=""

" gui only options
set belloff=all                                              " disable bell
set guioptions=                                              " disable all gui items
set guicursor+=a:blinkon0                                    " disable cursor blinking
if has('win32') || has('win64')                              " set the font according to os
  set guifont=Consolas:h10
elseif has('unix')
  set guifont=Liberation\ Mono\ 12
endif

" ========== HIGHLIGHT ========== "
" zenburn scheme
set background=dark
if has('gui_running')
  hi  clear
  hi! Normal       guifg=#dcdccc guibg=#3f3f3f gui=NONE
  hi! NonText      guifg=#7f7f7f guibg=NONE    gui=NONE
  hi! LineNr       guifg=#7f7f7f guibg=#0f0f0f gui=NONE
  hi! CursorLineNr guifg=#7f7f7f guibg=#0f0f0f gui=NONE
  hi! CursorLine   guifg=NONE    guibg=#0f0f0f gui=NONE
  hi! StatusLineNC guifg=#808080 guibg=#303030 gui=NONE
  hi! Statement    guifg=#e3ceab guibg=NONE    gui=bold
  hi! Type         guifg=#cedf99 guibg=NONE    gui=bold
  hi! Visual       guifg=NONE    guibg=#5f5f5f gui=NONE
  hi! Constant     guifg=#8cd0d3 guibg=NONE    gui=NONE
  hi! String       guifg=#cc9898 guibg=NONE    gui=NONE
  hi! PreProc      guifg=#ffcfaf guibg=NONE    gui=NONE
  hi! Comment      guifg=#7f9f7f guibg=NONE    gui=bold,italic
  hi! Operator     guifg=#9f9d6d guibg=NONE    gui=bold
  hi! VertSplit    guifg=NONE    guibg=#dcdccc gui=NONE
  hi! SpecialKey   guifg=#4d4d4d guibg=NONE    gui=NONE
  hi! Folded       guifg=#666666 guibg=#1a1a1a gui=NONE
  hi! Pmenu        guifg=#dcdccc guibg=#1a1a1a gui=NONE
  hi! PmenuSel     guifg=#0f0f0f guibg=#cccccc gui=bold
  hi! Todo         guifg=#bc8383 guibg=NONE    gui=bold,italic
  hi! MoreMsg      guifg=#bfebbf guibg=NONE    gui=bold
  hi! WarningMsg   guifg=#f0dfaf guibg=NONE    gui=underline
  hi! ErrorMsg     guifg=#dcdccc guibg=#9c6363 gui=underline
  hi! Search       guifg=#0f0f0f guibg=#f0dfaf gui=bold
  hi! Directory    guifg=#8cd0d3 guibg=NONE    gui=bold
  hi! Title        guifg=#f0dfaf guibg=NONE    gui=bold
  hi! link         Identifier    Statement
  hi! link         Special       String
  hi! link         MatchParen    Statement
  hi! link         Question      MoreMsg
  hi! link         TabLine       StatusLineNC
  hi! link         TabLineFill   StatusLineNC
endif

" ========== VARIABLES ========== "
" vim home location
if has('win32') || has('win64')
  let $VIMHOME=$HOME . '\vimfiles'
else
  let $VIMHOME=$HOME . '/.config/vim'
endif

" netrw variables
let g:netrw_banner=0
let g:netrw_winsize=20
let g:netrw_dirhistmax=0

" ========== KEYBINDINGS ========== "
" leader key
let mapleader=' '

" normal
nnoremap <silent> <c-l>     <cmd>bn<cr>
nnoremap <silent> <c-h>     <cmd>bp<cr>
nnoremap <silent> <c-k>     <cmd>bn<cr><cmd>bd #<cr>
nnoremap <silent> <leader>e <cmd>Ex<cr>
nnoremap <silent> <leader>w <cmd>set wrap!<cr>

" insert
inoremap <silent> <c-space> <c-x><c-o>

" visual
vnoremap <silent> K         :m '<-2<cr>gv
vnoremap <silent> J         :m '>+1<cr>gv
vnoremap <silent> <         <gv
vnoremap <silent> >         >gv

" ========== FUNCTIONS ========== "
fu! SyntaxRules()
  " syntax rules
  syn match    cCustomBraces    '[{}\[\]()]'
  syn match    cCustomOperators '[\.<>=!&|;\-+\*%\^,:]'
  syn match    cCustomDivision  '(/\|//)' contains=ALLBUT,Comment
  syn keyword  cTodo            contained TODO FIXME NOTE BUG BUGFIX XXX
  hi  def link cCustomBraces    Operator
  hi  def link cCustomOperators Operator
  hi  def link cCustomDivision  Operator
endfu

fu! CFileType()
  setl cindent cinoptions=(0,W4,w1,m1,l1,t0,g0
  call SyntaxRules()
  " tags location
  if filereadable($VIMHOME . '/systags')
    setl tags+=$VIMHOME/systags
  endif
endfu

" ========== AUTOCOMMANDS ========== "
aug clean_buffer
  au!
  au BufWritePre * let curr_pos=getpos('.')
  au BufWritePre * %s/\s\+$//e
  au BufWritePost * call cursor(curr_pos[1], curr_pos[2]) | unlet curr_pos
aug end

aug c_filetype
  au!
  au FileType c,cpp call CFileType()
aug end

aug java_filetype
  au!
  au FileType java call SyntaxRules()
aug end
