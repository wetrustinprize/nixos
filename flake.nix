{

  description = "My first flake!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      makeHome = {username, hostname}: home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = builtins.filter (x: x!= null) [
          ./users/${username}/home.nix
          (
            if builtins.pathExists ./users/${username}/${hostname}.nix
            then ./users/${username}/${hostname}.nix
            else null
          )
        ];
      };
    in {
      nixosConfigurations = {
        dionysus = lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/dionysus/configuration.nix ];
        };
      };
      homeConfigurations = {
        "wetrustinprize@dionysus" = makeHome { username = "wetrustinprize"; hostname = "dionysus"; };
      };
    };

}
