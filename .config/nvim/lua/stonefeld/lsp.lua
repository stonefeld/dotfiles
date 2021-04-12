-- Run 'pip3 install python-language-server[all]'.
require('lspconfig').pyls.setup { }

-- Run 'npm i -g typescript typescript-language-server'.
require('lspconfig').tsserver.setup { }

-- Run 'npm i -g vscode-html-languague-server'.
require('lspconfig').html.setup { }

-- Run 'npm i -g vscode-css-languague-server'.
require('lspconfig').cssls.setup { }

-- Run 'npm i -g vscode-json-languague-server'.
require('lspconfig').jsonls.setup { }

-- Install 'clangd with your package manager'.
require('lspconfig').clangd.setup { }

-- Run 'npm i -g vim-language-server'.
require('lspconfig').vimls.setup { }

-- Run 'pip3 install cmake-language-server'.
require('lspconfig').cmake.setup { }
