{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    clang
    elixir
    go
    jdk21
    nodejs_22
    pnpm
    python3
    rustup
  ];
}
