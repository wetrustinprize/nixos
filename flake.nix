{
  description = "Prize's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    affinity-nix = {
      url = "github:mrshmllow/affinity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    nixpkgs,
    home-manager,
    sops-nix,
    stylix,
    niri,
    ...
  }@inputs:
    let
      user = import ./user.nix;
      lib = nixpkgs.lib;
      hosts = import ./hosts;
      pkgs = import nixpkgs {
        inherit (user) system;
        config.allowUnfree = true;
      };
    in
  {
    nixosConfigurations = builtins.listToAttrs (
      builtins.map (host: {
        name = host;
        value = lib.nixosSystem {
          modules = [
            ./hosts/${host}/configuration.nix
            sops-nix.nixosModules.sops
            stylix.nixosModules.stylix
            niri.nixosModules.niri
            home-manager.nixosModules.home-manager {
              home-manager.backupFileExtension = "backup";

              home-manager.sharedModules = [
                inputs.sops-nix.homeManagerModules.sops
                inputs.spicetify-nix.homeManagerModules.spicetify
                inputs.nixcord.homeModules.nixcord
              ];

              home-manager.extraSpecialArgs = {
                inherit user;
                inherit inputs;
              };

              home-manager.users.${user.username} = {
                imports =  [
                  ./hosts/${host}/home.nix
                ];
              };
            }
          ];
          specialArgs = {
            hostname = host;
            inherit inputs;
            inherit user;
          };
        };
      }) hosts
    );
    devShells.${user.system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        sops # used to edit secrets
        croc # good cli to transfer files
      ];
    };
  };
}
