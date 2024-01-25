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
        key = "<leader>f";
        action = "<cmd>Ex<CR>";
    } 
    # basically, Alt arrows of vscode re-imagined for vim
    {
        mode = "v";
        key = "J";
        action = ">+1<CR>gv=gv";
    }
    {
        mode = "v";
        key = "K";
        action = "<-2<CR>gv=gv";
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
