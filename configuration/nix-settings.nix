{ user, ... }: {
  nix.settings = {
    experimental-features = ["nix-command" "flakes"]; # enable flakes

    substituters = [
      "https://nix-community.cachix.org" # cache for faster downloading packages (instead of building from source)
    ];

    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" # trust the cache public key
    ];
  };

  nixpkgs.config.allowUnfree = true; # allow non FOSS software and etc
  nixpkgs.hostPlatform = user.system;

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d"; # automatically delete configurations older than 7 days
    dates = "weekly";
  };

  programs = {
    # command line utility that makes applying changes easy and pretty
    nh = {
      enable = true;
      flake = "/home/${user.username}/nixos";
    };
  };
}
