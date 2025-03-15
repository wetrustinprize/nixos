{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../essentials/desktop.nix
    ../essentials/audio.nix
    ../essentials/virtualization.nix
    ../essentials/ai.nix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "poseidon";
  time.timeZone = "America/Sao_Paulo";

  users.users.wetrustinprize = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  virtualisation.docker.enableNvidia = true;

  services.ollama.acceleration = "cuda";

  system.stateVersion = "24.05";
}
