{ pkgs, ... } :
{
  boot = {
    initrd = {
      verbose = false; # remove logs
    };

    extraModulePackages = [ ];
    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = [ "silent" ]; # quieter logs
    consoleLogLevel = 0; # quieter logs

    plymouth.enable = true;

    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 2;

      timeout = 5;
    };
  };
}
