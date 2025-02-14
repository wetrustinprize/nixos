{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../essentials/desktop.nix
    ../essentials/audio.nix
    ../essentials/virtualization.nix
    ../essentials/development.nix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "wetrustinprize";
  time.timeZone = "America/Sao_Paulo";

  services.xserver.enable = true;

  users.users.wetrustinprize = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  system.stateVersion = "24.05";

}
