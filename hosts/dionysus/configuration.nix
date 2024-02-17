{ pkgs, lib, config, ... }:

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

  environment.systemPackages = with pkgs; [ bluetuith blueman ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  nixpkgs.config.nvidia.acceptLicense = true;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
    ];

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
