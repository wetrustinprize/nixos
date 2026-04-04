{...}: {
  flake.nixosModules.glances = {...}: {
    services.glances = {
      enable = true;
    };
  };
}
