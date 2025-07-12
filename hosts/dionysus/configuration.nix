{
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [
    ../common.nix
    ../audio.nix
    ../desktop.nix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "dionysus";
  networking.firewall = {
    enable = true;
  };

  time.timeZone = "America/Sao_Paulo";

  services.logind.lidSwitch = "suspend";

  powerManagement.enable = true;
  services.thermald.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  environment.systemPackages = with pkgs; [ bluetuith ];

  services.xserver = {
    xkb.layout = "br";
  };

  system.stateVersion = "24.05";
}
