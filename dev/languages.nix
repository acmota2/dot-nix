{ pkgs, unstable, ... }:
{
  environment.systemPackages = with pkgs; [
    clang
    # elixir
    unstable.go
    jdk
    nodejs_24
    uv
    unstable.pnpm
    unstable.python3
    unstable.rustup
  ];
}
