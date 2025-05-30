{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../desktop.nix
    ../audio.nix
    ../virtualization.nix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "poseidon";
  time.timeZone = "America/Sao_Paulo";

  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };

  services.ollama.acceleration = "cuda";

  system.stateVersion = "24.05";
}
