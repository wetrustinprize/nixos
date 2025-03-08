{ pkgs, lib, config, ... }:

{
  imports = [ ../common.nix ../essentials/audio.nix ../essentials/desktop.nix ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "dionysus";
  networking.firewall = { enable = true; };

  time.timeZone = "America/SaoPaulo";

  services.xserver.xkb.layout = "br";
  services.logind.lidSwitch = "suspend";

  powerManagement.enable = true;
  services.thermald.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  environment.systemPackages = with pkgs; [ bluetuith ];

  hardware.graphics.enable = true;

  nixpkgs.config.nvidia.acceptLicense = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
    modesetting.enable = true;
    nvidiaSettings = true;
    open = false;
    powerManagement.finegrained = false;
    powerManagement.enable = false;
  };
  hardware.nvidia.prime = {
    sync.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:3:0:0";
  };
}
