{inputs, ...}: {
  flake-file.inputs.spicetify-nix.url = "github:Gerg-L/spicetify-nix";

  flake.homeModules.spicetify = {...}: {
    imports = [
      inputs.spicetify-nix.homeManagerModules.spicetify
    ];

    programs.spicetify = {
      enable = true;
    };
  };
}
