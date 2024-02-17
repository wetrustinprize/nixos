{ pkgs, ... }:

{
  imports = [ ../common.nix ../desktop.nix ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;

  networking.hostName = "dionysus";

  time.timeZone = "America/SaoPaulo";

  services.xserver.layout = "br";

  powerManagement.enable = true;
  services.thermald.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  environment.systemPackages = with pkgs; [ bluetuith ];
}
