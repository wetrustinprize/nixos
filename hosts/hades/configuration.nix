{
  inputs,
  ...
}:

{
  imports = [
    ../common.nix
    ../audio.nix
    ../desktop.nix
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-e14-amd
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hades";
  networking.firewall = {
    enable = true;
  };

  time.timeZone = "America/Sao_Paulo";

  services.logind.lidSwitch = "hibernate";

  powerManagement.enable = true;
  services.thermald.enable = true;

  services.xserver.xkb = {
    layout = "br";
    variant = "thinkpad";
  };

  system.stateVersion = "25.05";
}
