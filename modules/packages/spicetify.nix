{...}: {
  flake.homeModules.spicetify = {...}: {
    programs.spicetify = {
      enable = true;
    };
  };
}
