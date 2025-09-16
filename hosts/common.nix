{
  pkgs,
  nixpkgs,
  lib,
  inputs,
  hostname,
  username,
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
    git
    jujutsu
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
    usbutils
    unrar
    unzip
    caligula
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
    users.${username} = {
      useDefaultShell = true;
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
    };
  };

  sops = {
    age.keyFile = "/home/${username}/.age.key";
    defaultSopsFile = ../../secrets.yaml;
  };

  environment.variables = {
    SOPS_AGE_KEY_FILE = "/home/${username}/.age.key";
  };

  programs.nix-ld.enable = true;
  programs.dconf.enable = true;

  require = [
    ./ssh.nix
  ];
}
