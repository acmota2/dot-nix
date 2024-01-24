{ pkgs, username, ... }:
{
    users.users.${username} = {
        extraGroups = [ "sound" ];
    };
    security.rtkit.enable = true;
    hardware.pulseaudio.enable = false;
    environment.systemPackages = with pkgs; [ pulseaudio ];
    services.pipewire = {
	    enable = true;
	    alsa = {
	        enable = true;
            support32Bit = true;
	    };
        pulse.enable = true;
        wireplumber.enable = true;
    };
}
