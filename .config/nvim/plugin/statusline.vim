" ---------- Statusline ---------- "
" Building custom statusline.
set statusline=
set statusline+=\ %{toupper(g:currentmode[mode()])}
set statusline+=\ %m\ %r
set statusline+=%=%{expand('%:~:.')}
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
