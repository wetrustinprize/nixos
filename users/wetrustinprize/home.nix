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

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  # this is to fix ssh config check on git functions inside vscode or other ssh clients
  # https://github.com/nix-community/home-manager/issues/322#issuecomment-1178614454
  home.file.".ssh/config" = {
    text = ''
      Include ~/.ssh/other_config

      Host *
        ForwardAgent no
        AddKeysToAgent yes
        Compression no
        ServerAliveInterval 0
        ServerAliveCountMax 3
        HashKnownHosts no
        UserKnownHostsFile ~/.ssh/known_hosts
        ControlMaster no
        ControlPath ~/.ssh/master-%r@%n:%p
        ControlPersist no
    '';
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
