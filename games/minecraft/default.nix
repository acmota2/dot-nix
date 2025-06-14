{ pkgs, ... }:
{
    programs.java.enable = true;
    environment.systemPackages = with pkgs; [ 
    	(pkgs.atlauncher.override { jre = pkgs.jdk21; })
    ];
}
