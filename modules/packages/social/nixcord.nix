{inputs, ...}: {
  flake-file.inputs.nixcord.url = "github:kaylorben/nixcord";

  flake.homeModules.nixcord = {...}: {
    imports = [
      inputs.nixcord.homeModules.nixcord
    ];

    programs.nixcord = {
      enable = true;
      vesktop.enable = true;

      config = {
        frameless = true;

        plugins = {
          anonymiseFileNames.enable = true;
          spotifyCrack.enable = true;
        };
      };
    };
  };
}
