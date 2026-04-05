{...}: {
  flake.homeModules.obs = {
    programs.obs-studio = {
      enable = true;
    };
  };
}
