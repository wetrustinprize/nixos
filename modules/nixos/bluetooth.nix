{...}: {
  flake.nixosModules.bluetooth = {...}: {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    services.blueman.enable = true;
  };

  flake.homeModules.bluetooth = {...}: {
    services.blueman-applet.enable = true;
  };
}
