{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    clang
    # elixir
    go
    jdk
    nodejs_22
    pnpm
    python3
    rustup
  ];
}
