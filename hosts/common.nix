{
  pkgs,
  nixpkgs,
  usernames,
  lib,
  inputs,
  hostname,
  ...
}:
{
  nixpkgs.overlays = [
    inputs.nix-your-shell.overlays.default
  ];

  nixpkgs.config.allowUnfree = true;
  networking.networkmanager.enable = true;

  programs.git.enable = true;

  environment.systemPackages = with pkgs; [
    nix-your-shell
    vim
    wget
    curl
    lm_sensors
    neofetch
    killall
    tldr
    htop
    sudo
    lshw
    fzf
    age
    sops
    bat
    zoxide
    lsof
    dysk
  ];

  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.fish.enable = true;

  users = {
    defaultUserShell = pkgs.fish;
    users = lib.listToAttrs (
      lib.map (username: {
        name = username;
        shell = pkgs.fish;
        value = {
          isNormalUser = true;
          extraGroups = [
            "networkmanager"
            "wheel"
            "docker"
          ];
        };
      }) usernames
    );
  };

  sops = {
    age.keyFile = "/home/wetrustinprize/.age.key";
    defaultSopsFile = ../../secrets.yaml;
  };

  environment.variables = {
    SOPS_AGE_KEY_FILE = "/home/wetrustinprize/.age.key";
  };

  programs.nix-ld.enable = true;
  programs.dconf.enable = true;

  require = [
    ./ssh.nix
  ];
}
