local lsp_zero = require('lsp-zero')

local lsp_zero_config = {
    call_servers = 'global',
}

-- Elixir
require'lspconfig'.elixirls.setup{}
-- Go
require'lspconfig'.gopls{}
-- Haskell
require('lspconfig')['hls'].setup{
  filetypes = { 'haskell', 'lhaskell', 'cabal' },
}
-- Java
require'lspconfig'.java_language_server.setup{}
-- Lua
-- Rust
-- TypeScript
require'lspconfig'.tsserver.setup{}

