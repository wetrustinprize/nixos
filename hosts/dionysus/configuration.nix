{ pkgs, lib, config, ... }:

{
  imports = [ ../common.nix ../desktop.nix ./hardware-configuration.nix ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
      "logmein-hamachi"
    ];

  boot.loader.systemd-boot.enable = true;

  networking.hostName = "dionysus";
  networking.firewall = {
    enable = true;
    allowedUDPPorts = [ 24454 ];
    allowedTCPPorts = [ 25565 ];
  };

  time.timeZone = "America/SaoPaulo";

  services.xserver.xkb.layout = "br";

  powerManagement.enable = true;
  services.thermald.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.blueman.enable = true;
  services.logmein-hamachi.enable = true;

  environment.systemPackages = with pkgs; [ bluetuith ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

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
