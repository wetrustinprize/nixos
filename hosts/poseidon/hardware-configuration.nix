{ pkgs, config, ... }: {
  imports = [
    ../../hardware
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  boot.kernelModules = [ "kvm-amd" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/150ed8a2-424a-409b-9816-3c802f7f4f60";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/973D-A4B0";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [ ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # nvidia related stuff for the RTX 4060
  services.xserver.videoDriver = "nvidia";
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  environment.systemPackages = with pkgs; [
    nvidia-vaapi-driver
  ];
}
