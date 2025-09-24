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
    parted
    gptfdisk
  ];

  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  programs.fish.enable = true;
  programs.npm.enable = true;

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
