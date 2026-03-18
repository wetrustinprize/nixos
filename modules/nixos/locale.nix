{...}: {
  flake.nixosModules.locale = {...}: {
    time.timeZone = "America/Sao_Paulo";

    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = builtins.listToAttrs (
        map (lc: {
          name = lc;
          value = "en_US.UTF-8";
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
}
