{...}: {
  flake.nixosModules.locale = {
    lib,
    config,
    ...
  }
  : let
    cfg = config.nyx.localization;
  in {
    options.nyx.localization = {
      locale = lib.mkOption {
        type = lib.types.str;
        default = "en_US.UTF-8";
        description = "The locale to use.";
      };
      timeZone = lib.mkOption {
        type = lib.types.str;
        default = "America/Sao_Paulo";
        description = "The time zone to use.";
      };
    };

    config = {
      time.timeZone = cfg.timeZone;

      i18n = {
        defaultLocale = cfg.locale;
        extraLocaleSettings = builtins.listToAttrs (
          map (lc: {
            name = lc;
            value = cfg.locale;
          }) [
            "LANGUAGE"
            "LC_TIME"
            "LC_ADDRESS"
            "LC_IDENTIFICATION"
            "LC_MEASUREMENT"
            "LC_MONETARY"
            "LC_NAME"
            "LC_NUMERIC"
            "LC_PAPER"
            "LC_TELEPHONE"
          ]
        );
      };
    };
  };
}
