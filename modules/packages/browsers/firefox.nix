{inputs, ...}: {
  flake.homeModules.firefox = {pkgs, ...}: {
    programs.firefox = {
      enable = true;

      profiles.prize = {
        isDefault = true;

        settings = {
          "extensions.autoDisableScopes" = 0;
          "extensions.enabledScopes" = 15;
        };

        extensions = {
          force = true;

          packages = with inputs.firefox-addons.packages.${pkgs.stdenv.system}; [
            ublock-origin
            bitwarden

            # development
            react-devtools

            # youtube
            youtube-high-definition
            sponsorblock
          ];
        };
      };
    };

    stylix.targets.firefox = {
      profileNames = ["prize"];
      colorTheme.enable = true;
    };
  };
}
