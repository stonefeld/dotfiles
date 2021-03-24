" ---------- Floaterm ---------- "
" Always close floaterm on exit.
let g:floaterm_autoclose=2
" Make rounded borders.
let g:floaterm_borderchars='─│─│╭╮╯╰'
" Set window size
let g:floaterm_width=0.8
let g:floaterm_height=0.8
" Disable window title
let g:floaterm_title=''
" Toggle floating terminals with F1.
let g:floaterm_keymap_toggle='<F1>'

" Keybindings.
nnoremap <silent> <leader>tt :FloatermToggle<CR>
nnoremap <silent> <leader>tg :FloatermNew lazygit<CR>
nnoremap <silent> <leader>tf :FloatermNew ranger<CR>
