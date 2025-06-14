{
    lualine.enable = true;
    nix.enable = true;
    telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>b" = "buffers";
          "<leader>fg" = "live_grep";
        };
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
            nixd.enable = true;
            gopls.enable = true;
            zls.enable = true;
            markdown_oxide.enable = true;
            svelte.enable = true;
        };
    };
    conform-nvim = {
      enable = true;
      settings.formatters_by_ft = {
        c = [ "clang-format" ];
        cpp = [ "clang-format" ];
        css = [ "prettierd" ];
        graphql = [ "prettierd" ];
        html = [ "prettierd" ];
        javascript = [ "prettier" ];
        javascriptreact = [ "prettier" ];
        json = [ "prettierd" ];
        lua = [ "stylua" ];
        nix = [ "nixfmt" ];
        python = [ "isort" ];
        rust = [ "rustfmt" ];
        svelte = [ "svelte" ];
        typescript = [ "prettierd" ];
        typescriptreact = [ "prettierd" ];
        yaml = [ "prettierd" ];
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
    web-devicons.enable = true;
}
