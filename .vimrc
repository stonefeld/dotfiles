" Enable syntax highlighting.
syntax on

" Enable filetype detection.
filetype plugin indent on

" Disable vi compatibility.
set nocompatible

" Disable spell checking and word wrapping.
set nospell
set nowrap

" Disable all type of junk files.
set noswapfile
set noundofile
set nobackup

" Scroll through the buffer 8 lines before the sides of the window.
set scrolloff=8
set sidescrolloff=8

" Allow opening another buffer if the current one has not been saved
" and disable start of line when jumping to the top of the file.
set hidden
set nostartofline

" Configure tab settings.
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

" Configure indentation.
set autoindent
set cindent

" Allow backspace over end of line and start of line.
set backspace=indent,eol,start
set colorcolumn=0

" Always split to the right and below
set splitright
set splitbelow

" Enable line number, show cursor position, enable interactive mouse and
" always show the statusline.
set nu
set ruler
set mouse=a
set laststatus=2

" Set updatetime to 250ms and disable unnecessary messages.
set updatetime=250
set shortmess+=c

" Search incrementally and don't maintain the search result highlight.
set incsearch
set nohlsearch

" Configure wildmenu settings.
set wildchar=<Tab>
set wildmenu
set wildmode=full

" Configure graphical settings.
set belloff=all
set guioptions=
set guicursor+=i-ci:block-iCursor
set guicursor+=r-cr:block-rCursor
set guicursor+=a:blinkon0

" Set font.
if filereadable(expand('~') . '\_vimrc')
  " set guifont=Liberation\ Mono:h9
  set guifont=Cascadia\ Code:h9
elseif filereadable(expand('~') . '/.vimrc')
  " set guifont=Liberation\ Mono\ 11
  set guifont=Cascadia\ Code\ 11
endif

" Highlight settings.
set background=dark
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
hi! VertSplit guifg=#afafaf guibg=#afafaf
hi! MatchParen guifg=#ff0000 guibg=NONE
hi! ModeMsg guifg=#cd950c gui=bold
hi! Pmenu guifg=#000000 guibg=#8b7355
hi! PmenuSel guifg=#000000

" If no character is present before the cursor act as normal tab, otherwise
" cycle the completion tags.
fu! TabOrComplete(...)
  if col('.') > 1 && strpart(getline('.'), col('.') - 2, 3) =~ '^\w'
    if a:0 == 1
      return "\<C-p>"
    else
      return "\<C-n>"
    endif
  else
    return "\<Tab>"
  endif
endfu

" Recursive search for keywords.
fu! RecursiveSearch()
  let search_term=input("Enter search term: ")
  if search_term
    exe "vimgrep /" . search_term . "/ ./**"
  endif
endfu

" Change easily tabsize.
fu! TabSize()
  let current_tabsize=&tabstop
  let tabsize=input("Enter tab size (current: " . current_tabsize . "): ")
  if tabsize
    exe "set tabstop=" . tabsize " softtabstop=" . tabsize " shiftwidth=" . tabsize
  endif
endfu

" If build.bat or build.sh is available in pwd set it as the make program.
if filereadable('build.bat')
  let &makeprg='build.bat'
elseif filereadable('build.sh')
  let &makeprg='build.sh'
endif

" Setting the leader key.
let mapleader=" "

" Buffer manipulation.
nnoremap <silent> <C-l> :bn<CR>
nnoremap <silent> <C-h> :bp<CR>
nnoremap <silent> <C-k> :bp<CR>:bd #<CR>

" Recursive search for keywords and set change tabsize easily.
nnoremap <silent> <leader>s :call RecursiveSearch() <bar> redraw!<CR>
nnoremap <silent> <leader>ts :call TabSize() <bar> redraw!<CR>

nnoremap <silent> <leader>ta :silent exe "!ctags --recurse=yes --exclude=.git --exclude=build " . getcwd()<CR>

" Quickfixlist manipulation.
nnoremap <silent> <leader>o :copen<CR>
nnoremap <silent> <leader>q :cclose<CR>
nnoremap <silent> <leader>n :try<bar>cnext<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>cfirst<bar>endtry<CR>
nnoremap <silent> <leader>p :try<bar>cprevious<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>clast<bar>endtry<CR>

" Open netrw.
nnoremap <silent> <leader>e :Lexplore<CR>

" Open shell.
nnoremap <silent> <leader>tt :silent exe 'shell'<CR>

" Source vim configuration.
if filereadable(expand('~') . '\_vimrc')
  nnoremap <silent> <leader><CR> :so ~\_vimrc<CR>:echomsg "Sourced _vimrc"<CR>
  nnoremap <silent> <leader><S-CR> :e ~\_vimrc<CR>
elseif filereadable(expand('~') . '/.vimrc')
  nnoremap <silent> <leader><CR> :so ~/.vimrc<CR>:echomsg "Sourced .vimrc"<CR>
  nnoremap <silent> <leader><S-CR> :e ~/.vimrc<CR>
endif

" Compile code.
nnoremap <silent> <M-m> :silent exe 'make' <bar> redraw!<CR>

" Cycle completion.
inoremap <silent> <Tab> <C-r>=TabOrComplete()<CR>
inoremap <silent> <S-Tab> <C-r>=TabOrComplete(1)<CR>

" Netrw settings.
let g:netrw_banner=0
let g:netrw_winsize=20
let g:netrw_dirhistmax=0

" Cleaning the current buffer.
aug CleanBuffer
  au!
  au BufWritePre * %s/\s\+$//e
  au FileType c,cpp au BufWritePre <buffer> %s/if(/if (/e
  au FileType c,cpp au BufWritePre <buffer> %s/for(/for (/e
  au FileType c,cpp au BufWritePre <buffer> %s/while(/while (/e
  au FileType c,cpp au BufWritePre <buffer> %s/switch(/switch (/e
  au FileType c,cpp au BufWritePre <buffer> %s/}break;/} break;/e
  au FileType c,cpp au BufWritePre <buffer> %s/){/) {/e
aug END

" Highlight some keywords when editing C/C++ files.
fu! CSyntaxHighlight()
  syn keyword cTodo contained BUG BUGFIX

  syn keyword cNote contained NOTE
  syn cluster cCommentGroup add=cNote
  hi def link cNote Note

  syn keyword cBoolean true false TRUE FALSE
  hi def link cBoolean Boolean
endfu

" Highlight note keyword in comments.
aug FtSyntaxHighlight
  au!
  au FileType c,cpp call CSyntaxHighlight()
aug END
