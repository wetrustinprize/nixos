{ config, lib, pkgs, ... }:

{
  imports = [ ../common.nix ../desktop.nix ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;

  networking.hostName = "dionysus";

  time.timeZone = "America/SaoPaulo";

  services.xserver.layout = "br";

}

