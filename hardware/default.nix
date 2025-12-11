{ pkgs, lib, user, config, ...} :
{
  nixpkgs.hostPlatform = lib.mkDefault user.system;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave"; # enable power saving on the cpu

  # update cpu microcode with firmware that allows redistribution
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware = {
    # always enable bluetooth
    bluetooth.enable = true;

    # always enable graphics drivers and enable a bunch of layers for it (including vulkan validation)
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        vulkan-validation-layers # helps catch and debug vulkan crashes
      ];
    };

    # enabled this so wacom tablet works
    opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
  };


  hardware.enableAllFirmware = true; # enable all firmware regardless of license
}
