{...}: {
  flake.nixosModules.graphics = {lib, ...}: {
    virtualisation.vmVariant = {
      virtualisation.qemu.options = lib.mkAfter [
        "-device virtio-gpu-gl"
        "-display gtk,gl=on"
      ];
    };

    services.xserver.videoDrivers = lib.mkAfter ["virtio"];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
