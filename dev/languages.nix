{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    go
    python3
    elixir
    pnpm
    nodejs_22
    jdk21
    rustup
  ];
}
