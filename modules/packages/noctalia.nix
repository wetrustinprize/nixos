{inputs, ...}: {
  flake-file.inputs.noctalia.url = "github:noctalia-dev/noctalia-shell";

  flake.homeModules.noctalia = {
    lib,
    config,
    ...
  }: let
    cfg = config.programs.noctalia-shell;
  in {
    imports = [inputs.noctalia.homeModules.default];

    options.programs.noctalia-shell.enableNiriIntegration = lib.mkEnableOption "enable Niri integration";

    config = lib.mkMerge [
      {
        programs.noctalia-shell = {
          enable = true;

          settings = {
            general = {
              animationSpeed = 2;
            };

            location = {
              name = "Curitiba";
            };

            wallpaper = {
              enable = false;
            };

            calendar = {
              cards = [
                {
                  enabled = true;
                  id = "calendar-header-card";
                }
                {
                  enabled = true;
                  id = "calendar-month-card";
                }
                {
                  enabled = false;
                  id = "timer-card";
                }
                {
                  enabled = true;
                  id = "weather-card";
                }
              ];
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
      }
      (lib.mkIf cfg.enableNiriIntegration {
        programs.niri.settings = {
          environment = {
            # required to open the app launcher
            QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
          };

          spawn-at-startup = lib.mkAfter [
            {
              argv = ["noctalia-shell"];
            }
          ];

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
      })
    ];
  };
}
