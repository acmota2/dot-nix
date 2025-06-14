{
    mini = {
        enable = true;
	modules.icons = true;
	mockDevIcons = true;
    };
    lsp = {
        enable = true;
        servers = {
            ts_ls.enable = true;
            lua_ls.enable = true;
            rust_analyzer = {
                enable = true;
                installCargo = false;
                installRustc = false;
            };
            # hls.enable = true;
            clangd.enable = true;
            gopls.enable = true;
            zls.enable = true;
        };
    };
    cmp = {
        enable = true;
        settings.mapping = {
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
        };
    };
    treesitter.enable = true;
}
