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
set cinoptions=(0,W4,w1,m1,l1,t0,g0  " indentation rues
set backspace=indent,eol,start       " enable using backspace in any case
set splitright                       " split to the right when vertical
set splitbelow                       " split to the bottom when horizontal
set ruler                            " show cursor coordinates
set mouse=a                          " enable mouse interaction
set laststatus=1                     " show statusline in any case
set showcmd                          " show extra information on the cmdline
set ttimeoutlen=50                   " time waited for a key code to complete
set updatetime=250                   " decrease updatetime delay
set shortmess+=c                     " disable cmd-line messages when autocomplete
set incsearch                        " search while typing
set wildmenu                         " enable wildmenu
set list                             " enable listchars
set listchars=tab:\ \ ,trail:.       " set characters to display tabs and trailing space
set t_Co=16                          " only set 16 available colors
set belloff=all                      " disable bell
set guioptions=                      " disable all graphical features
set guicursor+=a:blinkon0            " disable cursor blink

" change default font according to os
let g:fontsize=11
let g:fontname='Cascadia\ Code'

" highlight settings
hi! Normal guifg=white guibg=black
hi! Visual guibg=black gui=reverse ctermbg=256 cterm=reverse
hi! Function guifg=blue ctermfg=4
hi! SpecialKey guifg=grey30 ctermfg=8

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
    exe '%s/\<' . expand('<cword>') . '\>/' . new_name . '/g'
    exe "normal 'r"
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

" quickly toggle syntax highlight
let g:syn=1
fu! ToggleSyntax()
  if g:syn == 1
    syntax off
    let g:syn=0
  else
    syntax on
    let g:syn=1
	call CSyntax()
  endif
endfu

" change font for guifont according to os
fu! SetFont()
  if has('win32')
    exe 'set guifont=' . get(g:, 'fontname', 'Liberation\ Mono') . ':h' . get(g:, 'fontsize', 9)
  elseif has('unix')
    exe 'set guifont=' . get(g:, 'fontname', 'Liberation\ Mono') . '\ ' . get(g:, 'fontsize', 12)
  endif
endfu

" change faster the font size
fu! SetFontSize()
  let size=input('Enter font size (current: ' . get(g:, 'fontsize') . '): ')
  if len(size) != 0
	let g:fontsize=size
	call SetFont()
	redraw!
  endif
endfu

" add custom c/c++ syntax highlight
fu! CSyntax()
  syn match cType "\<[A-Z][a-zA-Z0-9]*\>"

  syn match cCustomMacro "\<[A-Z_]*\>"
  hi def link cCustomMacro PreProc

  syn match cCustomParen "(" contains=cParen,cCppParen
  syn match cCustomFunc "\w\+\s*(" contains=cCustomParen
  syn match cCustomScope "::"
  syn match cCustomClass "\w\+\s*::" contains=cCustomScope
  hi def link cCustomFunc Function
  hi def link cCustomClass Function

  syn match cCustomBraces "[{}\[\]()]"
  hi def link cCustomBraces Constant

  syn match cCustomOperators "[\.<>=!&|;\-+\*%\^,]"
  hi def link cCustomOperators Constant

  syn match cCustomDivision "(/\|//)" contains=ALLBUT,Comment
  hi def link cCustomDivision Braces

  syn keyword cTodo contained TODO FIXME NOTE BUG BUGFIX XXX

  syn match cCustomMemberAccess "\.\|->" nextgroup=cStructMember,cppTemplateKeyword
  syn match cStructMember "\<\h\w*\>\%((\|<\)\@!" contained
  syn cluster cParenGroup add=cStructMember
  syn cluster cPreProcGroup add=cStructMember
  syn cluster cMultiGroup add=cStructMember
  hi def link cStructMember Function
  hi def link cCustomMemberAccess Function
endfu

" ----------------------------------------
" add manpage command
runtime ftplugin/man.vim

" ----------------------------------------
" setting space a leader key
let mapleader=' '

" buffer manipulation
nnoremap <silent> <c-l> <cmd>bn<cr>
nnoremap <silent> <c-h> <cmd>bp<cr>
nnoremap <silent> <c-k> <cmd>bn<cr>:bd #<cr>

" using the predefined functions
nnoremap <silent> <leader>f <cmd>call RecursiveSearch()<bar>redraw!<cr>
nnoremap <silent> <leader>ts <cmd>call TabSize()<bar>redraw!<cr>

" updating the tags file
nnoremap <silent> <leader>ta <cmd>exe '!ctags --recurse=yes --exclude=.git --exclude=build --exclude=exercises ' . getcwd()<cr>

" using the quickfix window
nnoremap <silent> <leader>q <cmd>call QFixToggle()<cr>
nnoremap <silent> <leader>n <cmd>try<bar>cn<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>cfirst<bar>endtry<CR>
nnoremap <silent> <leader>p <cmd>try<bar>cp<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>clast<bar>endtry<CR>

" open netrw
nnoremap <silent> <leader>e <cmd>Lexplore<cr>

" toggle syntax
nnoremap <silent> <leader>s <cmd>call ToggleSyntax()<cr>

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

" change font size
nnoremap <silent> <leader>cs <cmd>call SetFontSize()<cr>

" ----------------------------------------
let g:netrw_banner=0
let g:netrw_winsize=20
let g:netrw_dirhistmax=0

" ----------------------------------------
" delete trailing space or incorrect formating options and set the cursor in
" the last position
aug clean_buffer
  au!
  au BufWritePre * let curr_pos=getpos('.')
  au BufWritePre * %s/\s\+$//e
  au FileType c,cpp au BufWritePre <buffer> %s/if(/if (/e
  au FileType c,cpp au BufWritePre <buffer> %s/for(/for (/e
  au FileType c,cpp au BufWritePre <buffer> %s/while(/while (/e
  au FileType c,cpp au BufWritePre <buffer> %s/switch(/switch (/e
  au FileType c,cpp au BufWritePre <buffer> %s/}break;/} break;/e
  au FileType c,cpp au BufWritePre <buffer> %s/\s* ++/++/e
  au BufWritePost * call cursor(curr_pos[1], curr_pos[2])
aug end

" use manpages to access developer manpages for c code
aug manpages
  au!
  au FileType c,cpp,man nnoremap <buffer><silent> K <cmd>exe 'Man ' . expand('<cword>') . '.3'<cr>
aug end

" set special options for the compile window
aug compile_window
  au!
  au FileType compile nnoremap <buffer><silent> <m-m> <cmd>wincmd q \| call Compile()<cr>
  au FileType compile nnoremap <buffer><silent> q <cmd>wincmd q<cr>
  au FileType compile setl nonumber foldcolumn=0
aug end

" add additional syntax highlight for c/c++ files
aug c_syntax
  au!
  au FileType c,cpp call CSyntax()
aug end

" set some special settings for writing html, css and javascript
aug web_dev
  au!
  au FileType html,css,javascript setl tabstop=2 softtabstop=2 shiftwidth=2
  au FileType html inoremap <silent> !<tab> <!DOCTYPE html><cr><html><cr><head><cr><meta charset="UTF-8"><cr><meta http-equiv="X-UA-Compatible" content="IE=edge"><cr><meta name="viewport" content="width=device-width, initial-scale=1"><cr><title></title><cr></head><cr><body><cr><++><cr></body><cr></html><esc>5kf>a
  au FileType html inoremap <silent> ;d<tab> <div class=""<++>><++></div><esc>15hi
  au FileType html inoremap <silent> ;h1<tab> <h1 class=""<++>><++></h1><esc>14hi
  au FileType html inoremap <silent> ;h2<tab> <h2 class=""<++>><++></h2><esc>14hi
  au FileType html inoremap <silent> ;h3<tab> <h3 class=""<++>><++></h3><esc>14hi
  au FileType html inoremap <silent> ;h4<tab> <h4 class=""<++>><++></h4><esc>14hi
  au FileType html inoremap <silent> ;bu<tab> <button class="" type="<++>"<++>><++></button><esc>30hi
  au FileType html inoremap <silent> ;in<tab> <input class="" type="<++>" id="<++>" value="<++>" placeholder="<++>"></input><esc>63hi
  au FileType html inoremap <silent> <c-l> <esc>:let @0=@/<cr>/<++><cr>:let @/=@0<cr>ca<
aug end

" set some special settings for writing latex
aug latex_writing
  au!
  au BufNewFile,BufRead *.tex setl ft=tex
  au FileType tex setl tabstop=2 softtabstop=2 shiftwidth=2 textwidth=80
  au FileType tex nnoremap <silent> <m-m> <cmd>w! \| exe '!compiler ' . expand('%:p')<cr>
  au FileType tex nnoremap <silent> <m-o> <cmd>exe '!setsid -f xdg-open ' . expand('%:r') . '.pdf' \| redraw!<cr>
  au FileType tex inoremap <silent> !<tab> \documentclass{article}<cr><cr>\usepackage[margin=1in]{geometry}<cr><cr>\title{}<cr>\author{<++>}<cr><cr>\begin{document}<cr><cr>\maketitle<cr><++><cr><cr>\end{document}<esc>8k$i
  au FileType tex inoremap <silent> ;be<tab> \begin{}<cr>\end{<++>}<esc>k$i
  au FileType tex inoremap <silent> ;s<tab> \section{}<cr><cr><++><esc>2k$i
  au FileType tex inoremap <silent> ;ss<tab> \subsection{}<cr><cr><++><esc>2k$i
  au FileType tex inoremap <silent> ;sss<tab> \subsubsection{}<cr><cr><++><esc>2k$i
  au FileType tex inoremap <silent> ;eq<tab> \[<cr><cr>\]<esc>ki
  au FileType tex inoremap <silent> ;ie<tab> $$ <++><esc>5hi
  au FileType tex inoremap <silent> ;e<tab> \textit{} <++><esc>5hi
  au FileType tex inoremap <silent> ;b<tab> \textbf{} <++><esc>5hi
  au FileType tex inoremap <silent> ;ce<tab> \begin{center}<cr><cr>\end{center}<esc>kA
  au FileType tex inoremap <silent> ;en<tab> \begin{enumerate}<cr>\item <cr>\end{enumerate}<esc>kA
  au FileType tex inoremap <silent> ;it<tab> \begin{itemize}<cr>\item <cr>\end{itemize}<esc>kA
  au FileType tex inoremap <silent> ;i<tab> <esc>cc\item<space>
  au FileType tex inoremap <silent> <c-l> <esc>:let @0=@/<cr>/<++><cr>:let @/=@0<cr>ca<
aug end

" ----------------------------------------
" solve the problem where i can't bind alt+<any_key>
let c='a'
while c<='z'
  exec "set <A-" . c . ">=\e" . c
  exec "imap \e" . c . " <A-" . c . ">"
  let c=nr2char(1 + char2nr(c))
endwhile

" ----------------------------------------
" execute functions at startup
call SetFont()
