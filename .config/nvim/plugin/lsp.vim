" ---------- LSP ---------- "
" Autocomplete options.
set complete+=kspell
set completeopt=menuone,noinsert,noselect

" Set python path.
let	g:python3_host_prog='~/.pyenv/versions/neovim3.9.1/bin/python'

" Keybindings.
nnoremap <silent> <C-]> :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <C-[> :lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> g0 :lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>ld :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> <leader>ca :lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>re :lua vim.lsp.buf.rename()<CR>
