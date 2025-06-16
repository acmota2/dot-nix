{ pkgs, lib, ... }:
{
  lualine.enable = true;
  nix.enable = true;
  telescope = {
    enable = true;
    keymaps = {
      "<leader>ff" = "find_files";
      "<leader>b" = "buffers";
      "<leader>fg" = "live_grep";
      "<leader>e" = "file_browser";
    };
    extensions.file-browser = {
      enable = true;
    };
  };
  lsp = {
    enable = true;
    keymaps = {
      lspBuf = {
        "<leader>r" = "rename";
        "gd" = "definition";
      };
    };
    # this is the correct option after 25.05
    #keymaps = [
    /*
      {
        # mode = [ "n" ];
        key = "<leader>r";
        lspBufAction = "rename";
      }
        {
          mode = "n";
          action = ''require('telescope.builtin').lsp_definitions'';
          key = "gd";
        }
    */
    #];
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
    settings = {
      formatters_by_ft = {
        c = [ "clang-format" ];
        cpp = [ "clang-format" ];
        css = [ "prettierd" ];
        graphql = [ "prettierd" ];
        html = [ "prettierd" ];
        javascript = [ "prettierd" ];
        javascriptreact = [ "prettierd" ];
        json = [ "prettierd" ];
        lua = [ "stylua" ];
        nix = [ "nixfmt" ];
        python = [ "isort" ];
        rust = [ "rustfmt" ];
        svelte = [ "pettierd" ];
        typescript = [ "prettierd" ];
        typescriptreact = [ "prettierd" ];
        yaml = [ "prettierd" ];
      };
      format_on_save.__raw = "{ }";
    };
  };
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
    };
  };
  markdown-preview.enable = true;
  treesitter = {
    enable = true;
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      bash
      json
      lua
      make
      markdown
      nix
      rust
      svelte
      typescript
      tsx
      toml
      vim
      yaml
    ];
    settings = {
      autoInstall = true;
      highlight.enable = true;
    };
  };
  web-devicons.enable = true;
}
