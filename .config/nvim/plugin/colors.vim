" ---------- Colors ---------- "
" Set default sonokai style.
let g:sonokai_style='andromeda'

" Enable termguicolors and set colorscheme to nordokai.
set termguicolors
colorscheme nordokai
set background=dark

" Override some highlights.
highlight FloatermBorder guibg=none

" Set syntax highlighting for every html file.
augroup htmlSyntax
  autocmd!
  autocmd BufNewFile,BufRead *.html   set filetype=html
augroup END
