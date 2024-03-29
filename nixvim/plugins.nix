{
    bufferline = {
        enable = true;
    };
    lsp = {
        enable = true;
        servers = {
            rnix-lsp.enable = true;
            tsserver.enable = true;
            lua-ls.enable = true;
            rust-analyzer = {
                enable = true;
                installCargo = false;
                installRustc = false;
            };
            hls.enable = true;
            clangd.enable = true;
            gopls.enable = true;
            zls.enable = true;
        };
    };
    nvim-cmp = {
        enable = true;
        sources = [
            {name = "path";}
            {name = "nvim_lsp";}
            {name = "cmp_tabnine";}
            {name = "luasnip";}
            {name = "neorg";}
        ];
        mapping = {
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
        };
    };
    treesitter.enable = true;
}
