[
  # select all
  {
    mode = "n";
    key = "<leader>a";
    action = "ggVG";
  }
  {
    mode = "n";
    key = "<leader>o";
    action = "<cmd>Oil<CR>";
  }
  {
    mode = "n";
    key = "<leader>sr";
    action = "<cmd>Spectre<CR>";
  }
  {
    mode = "n";
    key = "<leader>/";
    action = "<cmd>nohlsearch<CR>";
    options = {
      silent = true;
      noremap = true;
    };
  }
  # basically, Alt arrows of vscode re-imagined for vim, enhanced
  {
    mode = "v";
    key = "J";
    options.silent = true;
    action = "<cmd>lua vim.cmd(\"m '>+\" .. vim.v.count1 .. \"<CR>gv=gv\")<CR>";
  }
  {
    mode = "v";
    key = "K";
    options.silent = true;
    action = "<cmd>lua vim.cmd(\"m '<-\" .. (vim.v.count1 + 1) .. \"<CR>gv=gv\")<CR>";
  }
  # n - next, N - previous (searching terms)
  {
    mode = "n";
    key = "n";
    options.silent = true;
    action = "nzzzv";
  }
  {
    mode = "n";
    key = "N";
    options.silent = true;
    action = "Nzzzv";
  }
]
