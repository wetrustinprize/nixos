{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../essentials/virtualization.nix
    ../essentials/ai.nix
    ./hardware-configuration.nix
    ./containers/karakeep.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "atena";

  time.timeZone = "America/Sao_Paulo";

  system.stateVersion = "24.11";

}
