" ---------- Telescope ---------- "
" Keybindings.
nnoremap <silent> <C-p> :lua require('telescope.builtin').find_files()<CR>
nnoremap <silent> <leader>ps :lua require('telescope.builtin').live_grep()<CR>
nnoremap <silent> <leader>pa :lua require('telescope.builtin').buffers()<CR>
nnoremap <silent> <leader>pd :lua require('telescope.builtin').lsp_document_diagnostics()<CR>
nnoremap <silent> gr :lua require('telescope.builtin').lsp_references()<CR>
