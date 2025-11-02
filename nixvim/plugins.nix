{ ... }:
{
  cmp = {
    enable = true;
    settings = {
      mapping = {
        "<C-b>" = "cmp.mapping.scroll_docs(-4)";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-e>" = "cmp.mapping.abort()";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
      };
      autoEnableSources = true;
      sources = [
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "buffer"; }
      ];
      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;
      cmp-buffer.enable = true;
    };
  };
  comment = {
    enable = true;
    settings.mappings = {
      basic = true;
      extra = true;
    };
  };
  copilot-vim.enable = true;
  copilot-chat.enable = true;
  conform-nvim = {
    enable = true;
    settings = {
      formatters_by_ft = {
        bash = [ "shfmt" ];
        c = [ "clang-format" ];
        cpp = [ "clang-format" ];
        css = [ "prettierd" ];
        graphql = [ "prettierd" ];
        html = [ "prettierd" ];
        htmldjango = [ "prettierd" ];
        javascript = [ "prettierd" ];
        javascriptreact = [ "prettierd" ];
        json = [ "prettierd" ];
        lua = [ "stylua" ];
        nix = [ "nixfmt" ];
        python = [ "black" ];
        rust = [ "rustfmt" ];
        sh = [ "shfmt" ];
        svelte = [ "prettierd" ];
        typescript = [ "prettierd" ];
        typescriptreact = [ "prettierd" ];
        yaml = [ "prettierd" ];
        zsh = [ "shfmt" ];
      };
      format_on_save.__raw = "{ }";
    };
  };
  helm.enable = true;
  lsp-lines.enable = true;
  lsp-status = {
    enable = true;
    settings.diagnostics = false;
  };
  lsp-signature.enable = true;
  lsp = {
    enable = true;
    inlayHints = true;
    keymaps = {
      lspBuf = {
        "<leader>r" = "rename";
        "gd" = "definition";
      };
    };
    servers = {
      rust_analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;
      };
      # hls.enable = true;
      clangd.enable = true;
      gopls.enable = true;
      html.enable = true;
      htmx.enable = true;
      hyprls.enable = true;
      lua_ls.enable = true;
      markdown_oxide.enable = true;
      nixd.enable = true;
      pylsp.enable = true;
      svelte.enable = true;
      ts_ls.enable = true;
      yamlls.enable = true;
      zls.enable = true;
    };
  };
  lualine.enable = true;
  markdown-preview.enable = true;
  nix.enable = true;
  nix-develop.enable = true;
  oil.enable = true;
  telescope = {
    enable = true;
    keymaps = {
      "<leader>ff" = "find_files";
      "<leader>b" = "buffers";
      "<leader>fg" = "live_grep";
      "<leader>e" = "file_browser";
      "<leader>u" = "undo";
    };
    extensions = {
      file-browser.enable = true;
      undo.enable = true;
    };
  };
  treesitter = {
    enable = true;
    settings = {
      autoInstall = true;
      highlight.enable = true;
    };
  };
  trouble.enable = true;
  ts-autotag = {
    enable = true;
    settings = {
      opts = {
        enable_close = true;
        enable_close_on_slash = false;
        enable_rename = true;
      };
    };
  };
  vim-surround.enable = true;
  web-devicons.enable = true;
  yaml-schema-detect.enable = true;
}
