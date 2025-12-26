{ inputs, lib, config, ... }: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.sessionVariables = {
    # required to open the app launcher
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  };

  programs.noctalia-shell = {
    enable = true;

    # stylix wans't auto appliying the theme changes
    # copied the config from:
    # https://github.com/nix-community/stylix/blob/551df12ee3ebac52c5712058bd97fd9faa4c3430/modules/noctalia-shell/hm.nix

    colors = with config.lib.stylix.colors.withHashtag; {
      mPrimary = base05;
      mOnPrimary = base00;
      mSecondary = base05;
      mOnSecondary = base00;
      mTertiary = base04;
      mOnTertiary = base00;
      mError = base08;
      mOnError = base00;
      mSurface = base00;
      mOnSurface = base05;
      mHover = base04;
      mOnHover = base00;
      mSurfaceVariant = base01;
      mOnSurfaceVariant = base04;
      mOutline = base02;
      mShadow = base00;
    };

    settings = {
      ui.fontDefault = config.stylix.fonts.sansSerif.name;
      ui.fontFixed = config.stylix.fonts.monospace.name;

      general = {
        animationSpeed = 2;
      };

      location = {
        name = "Curitiba";
      };

      bar = {
        widgets = {
          left = [
            {
              id = "Clock";
              usePrimaryColor = false;
            }
            {
              id = "ActiveWindow";
            }
            {
              id = "MediaMini";
            }
          ];
          right = [
            {
              id = "SystemMonitor";
            }
            {
              id = "Volume";
            }
            {
              id = "ScreenRecorder";
            }
            {
              id = "NotificationHistory";
            }
            {
              id = "Tray";
            }
          ];
        };
      };
    };
  };

  programs.niri.settings = {
    spawn-at-startup = lib.mkAfter [{
      argv = ["noctalia-shell"];
    }];

    debug = {
      honor-xdg-activation-with-invalid-serial = true;
    };

    binds = {
      "Mod+P" = {
        action.spawn = ["noctalia-shell" "ipc" "call" "launcher" "toggle"];
        hotkey-overlay.title = "Toggle app launcher";
      };
      "Mod+Period" = {
        action.spawn = ["noctalia-shell" "ipc" "call" "launcher" "emoji"];
        hotkey-overlay.title = "Open emoji picker";
      };
      "Mod+0" = {
        action.spawn = ["noctalia-shell" "ipc" "call" "sessionMenu" "toggle"];
        hotkey-overlay.title = "Open clipboard manager";
      };
    };
  };
}
