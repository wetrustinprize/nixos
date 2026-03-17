{...}: {
  flake.nixosModules.boot = {pkgs, ...}: {
    boot = {
      initrd = {
        verbose = false; # remove logs
      };
      kernelParams = ["silent"]; # quieter logs
      consoleLogLevel = 0; # quieter logs

      kernelPackages = pkgs.linuxPackages_latest;
      plymouth.enable = true;
      loader = {
        systemd-boot.enable = true;
        systemd-boot.configurationLimit = 3;
        timeout = 3;
      };
    };
  };
}
