{ user, pkgs, inputs, ... }: {
  stylix.targets.firefox = {
    profileNames = [ user.username ];
    colorTheme.enable = true;
  };

  home.sessionVariables = {
    BROWSER = "firefox";
  };

  programs.firefox = {
    enable = true;

    profiles.${user.username} = {
      isDefault = true;

      settings = {
        "extensions.autoDisableScopes" = 0;
      };

      extensions = {
        force = true;

        # extensions from a nice flake
        # https://gitlab.com/rycee/nur-expressions/-/tree/master/pkgs/firefox-addons
        packages = with inputs.firefox-addons.packages.${pkgs.stdenv.system}; [
          ublock-origin
          bitwarden

          # youtube
          youtube-shorts-block
          redirect-shorts-to-youtube
          youtube-high-definition
          dearrow
        ];
      };
    };
  };

  xdg.mimeApps.defaultApplications = pkgs.lib.flatten
    (pkgs.lib.map (b: {
      ${b} = [ "firefox.desktop" ];
    }) [
      "text/html"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "x-scheme-handler/about"
      "x-scheme-handler/unknown"
    ]);
}
