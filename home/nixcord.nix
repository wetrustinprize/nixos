{ ... }: {
  programs.nixcord = {
    enable = true;
    vesktop.enable = true;

    config = {
      frameless = true;

      plugins = {
        alwaysAnimate.enable = true;
        anonymiseFileNames.enable = true;
        spotifyCrack.enable = true;
      };
    };
  };
}
