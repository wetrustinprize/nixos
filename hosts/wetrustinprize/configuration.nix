# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../desktop.nix
    ../audio.nix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "wetrustinprize";
  time.timeZone = "America/Sao_Paulo";

  services.xserver.enable = true;

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  services.printing.enable = true;

  users.users.wetrustinprize = {
    isNormalUser = true;
    description = "Prize";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      prismlauncher
      jdk17
      vscode
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    lm_sensors
  ];

  system.stateVersion = "24.05";

}
