{...}: {
  flake.nixosModules.git = {...}: {
    programs.git = {
      enable = true;
      lfs.enable = true;
    };
  };
}
