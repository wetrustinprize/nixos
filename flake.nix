{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    cursor-editor.url = "github:omarcresp/cursor-flake";
    nix-colors.url = "github:misterio77/nix-colors";
    nix-your-shell = {
      url = "github:MercuryTechnologies/nix-your-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-colors,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      mkConfig =
        {
          hostname,
          usernames ? [ ],
          system,
        }:
        lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit system;
            inherit usernames;
            inherit self;
          };
          modules =
            [
              ./hosts/${hostname}/configuration.nix
            ]
            ++ (lib.map (username: {
              imports = [
                home-manager.nixosModules.home-manager
                {
                  home-manager.extraSpecialArgs = {
                    inherit inputs;
                    inherit system;
                    inherit username;
                    inherit nix-colors;
                    inherit self;
                  };
                  home-manager.users.${username} = {
                    imports =
                      builtins.filter (x: x != null) [
                        ./users/${username}/home.nix
                        (
                          if builtins.pathExists ./users/${username}/hosts/${hostname}.nix then
                            ./users/${username}/hosts/${hostname}.nix
                          else
                            null
                        )
                      ]
                      ++ [ nix-colors.homeManagerModules.default ];
                  };
                }
              ];
            }) usernames);
        };
    in
    {
      lib = {
        nixColorsToCss = import ./utils/nixColorsToCss.nix { inherit lib; };
        nixColorsToGtkCss = import ./utils/nixColorsToGtkCss.nix { inherit lib; };
        nixColorsReplace = import ./utils/nixColorsReplace.nix { inherit lib; };
      };
      nixosConfigurations = {
        poseidon = mkConfig {
          inherit system;
          hostname = "poseidon";
          usernames = [ "wetrustinprize" ];
        };
        dionysus = mkConfig {
          inherit system;
          hostname = "dionysus";
          usernames = [ "wetrustinprize" ];
        };
		atena = mkConfig {
			inherit system;
			hostname = "atena";
			usernames = [ "wetrustinprize" ];
		};
      };
    };
}
