{...}: {
  flake.nixosModules.tablet = {...}: {
    # enabled this so wacom tablet works
    hardware.opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
  };
}
