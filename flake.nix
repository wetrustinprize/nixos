{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    cursor-editor.url = "github:omarcresp/cursor-flake";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      mkConfig = { hostname, usernames ? [ ], system }:
        lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; inherit system; inherit usernames; };
          modules = [
            ./hosts/${hostname}/configuration.nix
		  ]
		  ++ lib.map (username:
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit inputs; inherit system; inherit username; };

			  home-manager.users.${username} = {
				imports = builtins.filter (x: x != null) [
					./users/${username}/home.nix
					(if builtins.pathExists
					./users/${username}/hosts/${hostname}.nix then
						./users/${username}/hosts/${hostname}.nix
					else
						null)
					];
				};
			}) usernames;
        };
    in {
      nixosConfigurations = {
        wetrustinprize = mkConfig {
          inherit system;
          hostname = "wetrustinprize";
		  usernames = [ "wetrustinprize" ];
        };
      };
    };
}
