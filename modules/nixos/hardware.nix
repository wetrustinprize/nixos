{...}: {
  flake.nixosModules.hardware = {lib, ...}: {
    virtualisation.vmVariant = {
      virtualisation.memorySize = 4096;
      virtualisation.cores = 4;

      virtualisation.qemu.options = lib.mkAfter [
        "-display gtk,show-tabs=on"
      ];
    };

    hardware.enableAllFirmware = true;
    hardware.cpu.intel.updateMicrocode = true;
  };
}
