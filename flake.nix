{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      mkConfig = { hostname, username ? "wetrustinprize", system }:
        lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/${hostname}/configuration.nix
            home-manager.nixosModules.home-manager
            {
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
            }
          ];
        };
    in {
      nixosConfigurations = {
        dionysus = mkConfig {
          inherit system;
          hostname = "dionysus";
        };
      };
    };
}
