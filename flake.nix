{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nix-colors.url = "github:misterio77/nix-colors";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-your-shell = {
      url = "github:MercuryTechnologies/nix-your-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
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
      username = "wetrustinprize";
      lib = nixpkgs.lib;
      mkConfig =
        {
          hostname,
          system,
        }:
        lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit system;
            inherit hostname;
            inherit username;
            inherit self;
          };
          modules = [
            ./hosts/${hostname}/configuration.nix
            inputs.sops-nix.nixosModules.sops
            {
              imports = [
                home-manager.nixosModules.home-manager
                {
                  home-manager.extraSpecialArgs = {
                    inherit inputs;
                    inherit system;
                    inherit username;
                    inherit hostname;
                    inherit nix-colors;
                    inherit self;
                  };
                  home-manager.backupFileExtension = "backup";
                  home-manager.sharedModules = [
                    inputs.sops-nix.homeManagerModules.sops
                  ];
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
            }
          ];
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
        };
        dionysus = mkConfig {
          inherit system;
          hostname = "dionysus";
        };
        atena = mkConfig {
          inherit system;
          hostname = "atena";
        };
      };
    };
}
