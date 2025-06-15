[
  # select all
  {
    mode = "n";
    key = "<leader>a";
    action = "ggVG";
  }
  # vim explorer
  {
    mode = "n";
    key = "<leader>F";
    action = "<cmd>Ex<CR>";
  }
  # NERDTree
  /* {
         mode = "n";
         key = "<leader>e";
         action = "<cmd>NERDTree<CR>";
     }
  */
  # basically, Alt arrows of vscode re-imagined for vim
  {
    mode = "v";
    key = "J";
    options.silent = true;
    action = ":m '>+1<CR>gv=gv";
  }
  {
    mode = "v";
    key = "K";
    options.silent = true;
    action = ":m '<-2<CR>gv=gv";
  }
  # n - next, N - previous (searching terms)
  {
    mode = "n";
    key = "n";
    action = "nzzzv";
  }
  {
    mode = "n";
    key = "N";
    action = "Nzzzv";
  }
]
