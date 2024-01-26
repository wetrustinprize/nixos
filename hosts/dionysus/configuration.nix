{ config, lib, pkgs, ... }:

{
  imports =
    [
      ../common.nix
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;

  networking.hostName = "dionysus";

  time.timeZone = "America/SaoPaulo";

  services.xserver = {
    enable = true;
    displayManager = {
      gdm.enable = true;
      defaultSession = "none+i3";
    };
    windowManager.i3 = {
      enable = true;
    };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  system.stateVersion = "23.11";
}

