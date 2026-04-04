{...}: {
  flake.nixosModules.glances = {...}: {
    services.glances = {
      enable = true;
      openFirewall = true;
    };
  };
}
