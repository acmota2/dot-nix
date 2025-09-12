{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    aws-vault
  ];
}
