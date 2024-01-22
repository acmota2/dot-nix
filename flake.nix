{
	description = "Main flake";
	
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

		home-manager = {
			url = "github:nix-community/home-manager/release-23.11";

			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, ...}@inputs: {
    	nixosConfigurations = {
	        "TheLightBeast" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
    			modules = [
				    ./thinkpad.nix
		        ];
                console.keyMap = "pt-latin1";
		    };
            "TheChonkyBeast" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./thinkpad.nix
                ];
            };
        };
	};
}
