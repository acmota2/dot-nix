{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    clang
    # elixir
    go
    jdk
    nodejs_24
    pnpm
    python3
    rustup
  ];
}
