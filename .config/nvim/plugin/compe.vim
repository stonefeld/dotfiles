" ---------- LSP Compe ---------- "
" Keybindings.
inoremap <silent><expr> <C-o> compe#complete()

" General setup.
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.documentation = v:false

" Sources setup.
let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
