{ user, pkgs, ... }: {
  stylix.targets.firefox = {
    profileNames = [ user.username ];
    colorTheme.enable = true;
  };

  programs.firefox = {
    enable = true;

    profiles.${user.username} = {
      isDefault = true;

      extensions = {
        force = true;
      };
    };
  };

  programs.chromium = {
    enable = true;
  };

  xdg.mimeApps.defaultApplications = pkgs.lib.flatten
    (pkgs.lib.map (b: {
      ${b} = [ "firefox.desktop" "chromium-browser.desktop" ];
    }) ([
      "text/html"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "x-scheme-handler/about"
      "x-scheme-handler/unknown"
    ]));
}
