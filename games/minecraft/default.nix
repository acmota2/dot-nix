{ pkgs, ... }:
{
    programs.java.enable = true;
    environment.systemPackages = with pkgs; [ 
      (pkgs.atlauncher.override { 
        jre = jdk21_headless; 
      })
    ];
}
