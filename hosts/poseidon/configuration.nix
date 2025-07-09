{ pkgs, username, lib, ... }:

{
  imports = [
    ../common.nix
    ../desktop.nix
    ../audio.nix
    ../docker.nix
    ../virt-manager.nix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "poseidon";
  time.timeZone = "America/Sao_Paulo";

  environment.systemPackages = with pkgs; [
    android-tools
  ];
  programs.adb.enable = true;
  users.users.${username}.extraGroups = lib.mkAfter ["adbusers"];

  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };

  services.ollama.acceleration = "cuda";

  system.stateVersion = "24.05";
}
