{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../essentials/virtualization.nix
    ../essentials/ai.nix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "atena";

  time.timeZone = "America/Sao_Paulo";

  users.users.wetrustinprize.linger = true;

  system.stateVersion = "24.11";
}
