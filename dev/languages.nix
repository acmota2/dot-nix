{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    go
    python3
    elixir
    nodePackages.npm
    nodejs_22
    jdk21
    rustup
  ];
}
