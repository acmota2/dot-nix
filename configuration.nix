# yes, I made a new one, blame me
{ configs, pkgs, ... }:

{
    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

    environment.systemPackages = with pkgs; [
        git
        neovim
        wget
        curl
        kitty
        zsh
        brave
        rofi
        hyprpaper
        discord
        pulseaudio
        brightnessctl
        # vscodium
        docker
        coreutils-full
        libgcc
        gdb
        go
        cargo
        python3
        elixir
    ];
    
    programs.zsh.enable = true;    
 
    environment.variables.EDITOR = "nvim";
    # boot.loader = {
    #     efi = {
    #         canTouchEfiVariables = true;
    #         efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
    #     };
    #     grub = {
    #     	    enable = true;
    #         	efiSupport = true;
    #     };
    # };
    networking.networkmanager.enable = true;

    time.timeZone = "Europe/Berlin";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
    	LC_ADDRESS = "pt_PT.UTF-8";
    	LC_IDENTIFICATION = "pt_PT.UTF-8";
    	LC_MEASUREMENT = "pt_PT.UTF-8";
    	LC_MONETARY = "pt_PT.UTF-8";
    	LC_NAME = "pt_PT.UTF-8";
    	LC_NUMERIC = "pt_PT.UTF-8";
    	LC_PAPER = "pt_PT.UTF-8";
    	LC_TELEPHONE = "pt_PT.UTF-8";
	    LC_TIME = "pt_PT.UTF-8";
    };
    
    users.users.acmota2 = {
    	isNormalUser = true;
	    description = "acmota2";
    	extraGroups = [
    	    "docker"
    	    "networkmanager"
	        "wheel"
	    ];
    	packages = with pkgs; [
	        macchina
	        grimblast
	    ];
	    shell = pkgs.zsh;
    };

    services.pipewire = {
	    enable = true;
	    alsa = {
	        enable = true;
            support32Bit = true;
	    };
        pulse.enable = true;
        wireplumber.enable = true;
    };
    
    fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-emoji
        fira-code
        fira-code-symbols
        font-awesome
        nerdfonts
    ];

    system.stateVersion = "23.11";
}
