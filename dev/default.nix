{ pkgs, username, ... }: {
  environment.systemPackages = with pkgs; [ docker commitizen ripgrep ];
  users.users."${username}".extraGroups = [ "docker" ];
}
