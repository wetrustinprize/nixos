{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
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
                  ./users/hosts/${username}/${hostname}.nix then
                    ./users/hosts/${username}/${hostname}.nix
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
