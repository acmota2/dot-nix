{ pkgs, isPotato, ... }:
{
    environment.systemPackages = with pkgs;
    #let
    #    hasDaVinci = if !isPotato then [ davinci-resolve ] else [];
    #in 
    [
        gimp
        musescore
        reaper
    ]; # ++ hasDaVinci;
}
