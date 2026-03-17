{...}: {
  flake.nixosModules.nvidia = {
    config,
    pkgs,
    lib,
    ...
  }: {
    services.xserver.videoDrivers = lib.mkBefore ["nvidia"];
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
      nvtopPackages.nvidia
    ];
  };
}
