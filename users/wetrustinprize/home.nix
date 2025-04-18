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
    libqalculate
    megacmd
    gh
  ];

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

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
    ./modules/nushell.nix
    ./modules/yazi.nix
    ./modules/starship.nix
  ];

  home.stateVersion = "24.05";
}
