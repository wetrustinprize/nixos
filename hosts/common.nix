{
  pkgs,
  nixpkgs,
  usernames,
  lib,
  inputs,
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
  ];

  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  users = {
    defaultUserShell = pkgs.nushell;
    users = lib.listToAttrs (
      lib.map (username: {
        name = username;
        shell = pkgs.nushell;
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

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    openFirewall = true;
  };

  programs.nix-ld.enable = true;
  programs.dconf.enable = true;

  system.stateVersion = "24.05";
}
