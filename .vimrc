"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
" (_)_/ |_|_| |_| |_|_|  \___|

syntax on                            " enable syntax highlight

set nocompatible                     " no vi compatibility
set nospell                          " no spell checking
set nowrap                           " display long lines in one line
set noswapfile                       " disable swapfile
set noundofile                       " disable undofile
set nobackup                         " disable backup
set scrolloff=3                      " start scrolling 3 lines after
set sidescrolloff=3                  " same as scrolloff but horizontally
set hidden                           " allow opening another file with unsaved buffer
set nostartofline                    " when on top disable jumping to the top
set tabstop=4                        " make tabs 4 sapces long
set softtabstop=4                    " delete 4 spaces when backspace
set shiftwidth=4                     " use 4 spaces for shifting
set noexpandtab                      " use tabs by default
set smarttab                         " enable smart tabs
set autoindent                       " use the same indent level of line before
set cindent                          " use c-style indenting
set cinoptions=(0,l1,t0,=0           " indentation rues
set backspace=indent,eol,start       " enable using backspace in any case
set splitright                       " split to the right when vertical
set splitbelow                       " split to the bottom when horizontal
set ruler                            " show cursor coordinates
set mouse=a                          " enable mouse interaction
set laststatus=1                     " show statusline in any case
set foldcolumn=1                     " extra column for folding signs
set updatetime=250                   " decrease updatetime delay
set shortmess+=c                     " disable cmd-line messages when autocomplete
set incsearch                        " search while typing
set wildmenu                         " enable wildmenu
set list                             " enable listchars
set listchars=tab:\¦\ ,trail:.       " set characters to display tabs and trailing space
set belloff=all                      " disable bell
set guioptions=                      " disable all graphical features
set guicursor+=i-ci:block-iCursor    " set insert mode cursor
set guicursor+=r-cr:block-rCursor    " set replace mode cursor
set guicursor+=a:blinkon0            " disable cursor blink

" change default font according to os
if has('win32')
  " set guifont=Liberation\ Mono:h9
  set guifont=Cascadia\ Code:h9
  " set guifont=Courier\ New:h9
elseif has('unix')
  " set guifont=Liberation\ Mono\ 11
  set guifont=Cascadia\ Code\ 11
  " set guifont=Courier\ New\ 11
endif

set background=dark                " specify that the colorscheme is dark
colorscheme default                " set colorscheme

" highlight settings
hi! Normal guifg=#cdaa7d guibg=#161616
hi! Statement guifg=#cd950c guibg=NONE gui=none
hi! link Type Statement
hi! link Identifier Statement
hi! String guifg=#6b8e23 guibg=NONE
hi! link Character String
hi! link Special String
hi! link Constant String
hi! PreProc guifg=#f0e68c guibg=NONE
hi! Comment guifg=#7d7d7d guibg=NONE
hi! Todo guifg=#ff0000 guibg=NONE gui=bold
hi! Note guifg=#00ff00 guibg=NONE gui=bold
hi! LineNr guifg=#3d3d3d guibg=NONE
hi! CursorLine guifg=NONE guibg=#000044
hi! link QuickFixLine CursorLine
hi! Visual guifg=NONE guibg=#0000aa
hi! Cursor guifg=#000000 guibg=#40ff40
hi! iCursor guifg=#000000 guibg=#ff4040
hi! rCursor guifg=#000000 guibg=#4040ff
hi! StatusLine guifg=#afafaf guibg=#000000
hi! StatusLineNC guifg=#404040 guibg=#dfdfdf
hi! link TabLineSel StatusLine
hi! link TabLine StatusLineNC
hi! link TabLineFill StatusLineNC
hi! link FoldColumn Normal
hi! VertSplit guifg=#afafaf guibg=#afafaf
hi! MatchParen guifg=#ff0000 guibg=NONE
hi! ModeMsg guifg=#cd950c gui=bold
hi! Pmenu guifg=#ffffff guibg=#262626
hi! PmenuSel guifg=#000000 guibg=#a6a6a6
hi! SpecialKey guifg=grey30

" if build.bat or build.sh are available set them as the makeprg
if has('win32') && filereadable('build.bat')
  let &makeprg='build.bat'
elseif has('unix') && filereadable('build.sh')
  let &makeprg='build.sh'
endif

" ----------------------------------------
" search recursively for search terms
fu! RecursiveSearch()
  let search_term=input('Enter search term: ')
  if len(search_term) != 0
    exe 'vimgrep /' . search_term . '/ **'
  endif
endfu

" rename all ocurrences of a word in the current buffer
fu! Rename()
  let new_name=input('Enter new name (' . expand('<cword>') . '): ')
  if len(new_name) != 0
    exe 'mark r'
    exe '%s/\\<' . expand('<cword>') . '\\>/' . new_name '/g'
    exe 'normal 'r'
  endif
endfu

" change tab size on the fly
fu! TabSize()
  let current_size=&tabstop
  let new_size=input('Enter tab size (current: ' . current_size . '): ')
  if len(new_size) != 0
    exe 'set tabstop=' . new_size . ' softtabstop=' . new_size . ' shiftwidth=' . new_size
  endif
endfu

" toggle quickfix window
fu! QFixToggle()
  if exists('g:qfix_win')
    exe 'cclose'
    unlet g:qfix_win
  else
    exe 'copen'
    let g:qfix_win=bufnr('$')
  endif
endfu

" open a vertical split to compile the code
fu! Compile()
  let program=&makeprg
  wincmd o
  vertical split
  exe 'term ' . program
  let g:compile_buf=bufnr('$')
  wincmd k
  wincmd q
  set filetype=compile
endfu

" before compiling check if a compile window already exists
fu! CheckCompile()
  if exists('g:compile_buf')
    let prev_buf=bufnr('%')
    if bufwinnr(g:compile_buf) > 0
      exe 'buffer ' . g:compile_buf
      bd
      exe 'buffer ' . prev_buf
    else
      unlet g:compile_buf
    endif
  endif
  call Compile()
endfu

" ----------------------------------------
" setting space a leader key
let mapleader=' '

" buffer manipulation
nnoremap <silent> <c-l> <cmd>bn<cr>
nnoremap <silent> <c-h> <cmd>bp<cr>
nnoremap <silent> <c-k> <cmd>b #<cr>:bd #<cr>

" using the predefined functions
nnoremap <silent> <leader>s <cmd>call RecursiveSearch()<bar>redraw!<cr>
nnoremap <silent> <leader>ts <cmd>call TabSize()<bar>redraw!<cr>

" updating the tags file
nnoremap <silent> <leader>ta <cmd>exe '!ctags --recurse=yes --exclude=.git --exclude=build --exclude=exercises ' . getcwd()<cr>

" using the quickfix window
nnoremap <silent> <leader>q <cmd>call QFixToggle()<cr>
nnoremap <silent> <leader>n <cmd>try<bar>cn<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>cfirst<bar>endtry<CR>
nnoremap <silent> <leader>p <cmd>try<bar>cp<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>clast<bar>endtry<CR>

" open netrw
nnoremap <silent> <leader>e <cmd>Lexplore<cr>

" rename word under cursor
nnoremap <silent> <leader>rn <cmd>call Rename()<cr>

" compile the code
nnoremap <silent> <m-m> <cmd>call CheckCompile()<cr>

" move lines up and down while selected
vnoremap <silent> K :m '<-2<cr>gv
vnoremap <silent> J :m '>+1<cr>gv

" stay in indent mode
vnoremap <silent> < <gv
vnoremap <silent> > >gv

" source vim configuration
if has('win32') && filereadable(expand('~') . '\_vimrc')
  nnoremap <silent> <leader><cr> <cmd>so ~\_vimrc<cr><cmd>echomsg 'Sourced _vimrc'<cr>
  nnoremap <silent> <leader><s-cr> <cmd>e ~\_vimrc<cr>
elseif has('unix') && filereadable(expand('~') . '/.vimrc')
  nnoremap <silent> <leader><cr> <cmd>so ~/.vimrc<cr><cmd>echomsg 'Sourced .vimrc'<cr>
  nnoremap <silent> <leader><s-cr> <cmd>e ~/.vimrc<cr>
endif

" ----------------------------------------
let g:netrw_banner=0
let g:netrw_winsize=20
let g:netrw_dirhistmax=0

" ----------------------------------------
" delete trailing space or incorrect formating options
aug clean_buffer
  au!
  au BufWritePre * %s/\s\+$//e
  au FileType c,cpp au BufWritePre <buffer> %s/if(/if (/e
  au FileType c,cpp au BufWritePre <buffer> %s/for(/for (/e
  au FileType c,cpp au BufWritePre <buffer> %s/while(/while (/e
  au FileType c,cpp au BufWritePre <buffer> %s/switch(/switch (/e
  au FileType c,cpp au BufWritePre <buffer> %s/}break;/} break;/e
aug end

" set special options for the compile window
aug compile_window
  au!
  au FileType compile nnoremap <buffer><silent> <m-m> <cmd>wincmd q \| call Compile()<cr>
  au FileType compile nnoremap <buffer><silent> q <cmd>wincmd q<cr>
  au FileType compile setl nonumber foldcolumn=0
aug end
