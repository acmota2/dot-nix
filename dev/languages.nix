{ pkgs, unstable, ... }:
{
  environment.systemPackages = [
    pkgs.clang
    # elixir
    unstable.go
    pkgs.jdk
    pkgs.nodejs_24
    unstable.pnpm
    unstable.python3
    unstable.rustup
  ];
}
