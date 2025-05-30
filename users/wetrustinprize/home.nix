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

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    includes = [
      "~/.ssh/other_config"
    ];
  };

  programs.git = {
    enable = true;
    userEmail = "me@wetrustinprize.com";
    userName = "wetrustinprize";
  };

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.age.key";
    defaultSopsFile = ../../secrets.yaml;
  };

  require = [
    ./modules/shell.nix
    ./modules/yazi.nix
  ];

  home.stateVersion = "24.05";
}
