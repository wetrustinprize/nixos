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
              enabled = false;
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

            audioVisualizer = {
              width = 50;
            };

            dock = {
              enabled = false;
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
                    id = "AudioVisualizer";
                  }
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
          spawn-at-startup = lib.mkAfter [
            {
              argv = ["noctalia-shell"];
            }
          ];

          debug = {
            honor-xdg-activation-with-invalid-serial = true;
          };

          binds = {
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
