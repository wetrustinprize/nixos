{inputs, ...}
: let
  stateVersion = "26.05";
in {
  flake.nixosModules.nix-settings = {...}: {
    imports = [inputs.nix-index-database.nixosModules.default];

    system.stateVersion = stateVersion;

    nix.settings = {
      substituters = [
        "https://nix-community.cachix.org" # cache for faster downloading packages (instead of building from source)
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" # trust the cache public key
      ];

      experimental-features = ["nix-command" "flakes" "pipe-operators"]; # enable some experimental features
    };

    nixpkgs.config.allowUnfree = true;
    nixpkgs.hostPlatform = "x86_64-linux";

    nix.gc = {
      automatic = true;
      options = "--delete-older-than 7d";
      dates = "weekly";
    };

    programs = {
      nh = {
        enable = true;
        flake = "/home/wetrustinprize/nixos";
      };

      nix-index-database = {
        comma.enable = true;
      };

      nix-index.enable = true;
    };
  };

  flake.homeModules.nix-settings = {
    imports = [inputs.nix-index-database.homeModules.default];

    home.stateVersion = stateVersion;

    programs.nix-index-database.comma.enable = true;
    programs.nix-index.enable = true;
  };
}
