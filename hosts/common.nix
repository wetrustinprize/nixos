{
  pkgs,
  nixpkgs,
  usernames,
  lib,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;
  networking.networkmanager.enable = true;

  programs.git.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    lm_sensors
    neofetch
    killall
    tldr
    htop
  ];

  boot.plymouth = {
    enable = true;
    theme = "nixos-bgrt";
    themePackages = [ pkgs.nixos-bgrt-plymouth ];
  };

  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  users.users = lib.listToAttrs (
    lib.map (username: {
      name = username;
      value = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "docker"
        ];
      };
    }) usernames
  );

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    openFirewall = true;
  };


  programs.dconf.enable = true;

  system.stateVersion = "24.05";
}
