{ pkgs, lib, user, config, ...} :
{
  nixpkgs.hostPlatform = lib.mkDefault user.system;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave"; # enable power saving on the cpu

  # always enable bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # update cpu microcode with firmware that allows redistribution
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # always enable graphics drivers and enable a bunch of layers for it (including vulkan validation)
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vulkan-validation-layers # helps catch and debug vulkan crashes
    ];
  };

  # enabled this so wacom tablet works
  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };

  hardware.enableAllFirmware = true; # enable all firmware regardless of license
}
