{ pkgs, isPotato, ... }:
{
    environment.systemPackages = with pkgs;
    let
        hasDaVinci = if !isPotato then [ davinci ] else [];
    in [
        gimp
        musescore
        reaper
    ] ++ hasDaVinci;
}
