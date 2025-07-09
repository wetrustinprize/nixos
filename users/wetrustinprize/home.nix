{
  pkgs,
  system,
  inputs,
  lib,
  nixpkgs,
  username,
  nix-colors,
  config,
  ...
}:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      inputs.nix-your-shell.overlays.default
    ];
  };

  colorScheme = nix-colors.colorSchemes.nord;

  home.username = username;

  home.packages = with pkgs; [
    nixfmt-rfc-style
    pinentry
    gh
  ];

  programs.git = {
    enable = true;
    userEmail = "git@${username}.com";
    userName = username;
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      email = "git@${username}.com";
      name = username;
    };
  };

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.age.key";
    defaultSopsFile = ../../secrets.yaml;
  };

  require = [
    ./modules/shell.nix
    ./modules/ssh.nix
  ];

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  home.stateVersion = "24.05";
}
