{
  inputs,
  self,
  ...
}: {
  flake-file.inputs.niri.url = "github:sodiboo/niri-flake";

  flake.nixosModules.niri = {pkgs, ...}: {
    imports = [
      inputs.niri.nixosModules.niri
      self.nixosModules.wayland
    ];

    nixpkgs.overlays = [
      inputs.niri.overlays.niri
    ];

    programs.niri = {
      package = pkgs.niri;
      enable = true;
    };
  };

  flake.homeModules.niri = {
    pkgs,
    lib,
    config,
    ...
  }: {
    nixpkgs.overlays = [
      inputs.niri.overlays.niri
    ];

    home.packages = with pkgs; [
      xwayland-satellite
      nirius
    ];

    programs.niri = {
      settings = {
        prefer-no-csd = true;

        spawn-at-startup = lib.mkAfter [
          {
            argv = ["niriusd"];
          }
        ];

        input = {
          focus-follows-mouse.enable = true;
          workspace-auto-back-and-forth = true;
        };

        overview = {
          backdrop-color = config.lib.stylix.colors.withHashtag.base00;
        };

        gestures = {
          hot-corners.enable = false;
        };

        cursor = {
          hide-when-typing = true;
        };

        screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

        hotkey-overlay = {
          hide-not-bound = true;
          skip-at-startup = true;
        };

        layout = {
          background-color = "transparent";
        };

        layer-rules = [
          {
            matches = [
              # matches for swaybg
              {namespace = "^wallpaper$";}
            ];

            place-within-backdrop = true;
          }
        ];

        window-rules = [
          {
            # global window rules
            clip-to-geometry = true;
            geometry-corner-radius = {
              top-left = 8.0;
              top-right = 8.0;
              bottom-left = 8.0;
              bottom-right = 8.0;
            };
          }
          {
            matches = [
              # matches windows being casted
              {is-window-cast-target = true;}
            ];

            focus-ring = {
              active = {color = "#f38ba8";};
              inactive = {color = "#7d0d2d";};
            };

            shadow = {
              enable = true;
              color = "#7d0d2d70";
              softness = 10.0;
              spread = 1.0;
            };

            tab-indicator = {
              active = {color = "#f38ba8";};
              inactive = {color = "#7d0d2d";};
            };

            border = {
              active = {color = "#f38ba8";};
              inactive = {color = "#7d0d2d";};
            };
          }
          {
            matches = [
              # matches for pip windows
              {
                title = "(?i)^Picture-in-Picture";
              }
            ];

            default-column-width.fixed = 480;
            default-window-height.fixed = 270;
            open-floating = true;
          }
        ];

        binds = let
          foreachWorkspace = fn:
            pkgs.lib.range 1 9
            |> pkgs.lib.map fn;
        in
          pkgs.lib.attrsets.mergeAttrsList (pkgs.lib.flatten [
            {
              "Mod+Space" = {
                action.toggle-overview = [];
              };

              # spawners
              "Mod+T" = {
                action.spawn-sh = ["$TERMINAL"];
                hotkey-overlay.title = "Spawn terminal";
              };

              # window control
              "Mod+Q" = {
                action.close-window = [];
                repeat = false;
              };

              # mouse control
              "Mod+WheelScrollDown" = {
                action.focus-column-left = [];
              };
              "Mod+WheelScrollUp" = {
                action.focus-column-right = [];
              };
              "Mod+Shift+WheelScrollDown" = {
                action.focus-window-down = [];
              };
              "Mod+Shift+WheelScrollUp" = {
                action.focus-window-up = [];
              };

              # modes
              "Mod+F" = {
                action.fullscreen-window = [];
              };
              "Mod+W" = {
                action.toggle-column-tabbed-display = [];
              };

              # screenshot
              "Print" = {
                action.screenshot = [];
              };
              "Ctrl+Print" = {
                action.screenshot-screen = [];
              };
              "Shift+Print" = {
                action.screenshot-window = [];
              };

              # audio control
              "XF86AudioRaiseVolume" = {
                action.spawn = ["pamixer" "-i" "10"];
                cooldown-ms = 500;
              };
              "XF86AudioLowerVolume" = {
                action.spawn = ["pamixer" "-d" "10"];
                cooldown-ms = 500;
              };
            }
            (foreachWorkspace (i: {
              "Mod+${toString i}" = {
                action.focus-workspace = [i];
                hotkey-overlay.title = "Go to workspace ${toString i}";
              };
            }))
            (foreachWorkspace (i: {
              "Mod+Ctrl+${toString i}" = {
                action.move-column-to-workspace = [i];
                hotkey-overlay.title = "Move column to workspace ${toString i}";
              };
            }))
            (foreachWorkspace (i: {
              "Mod+Shift+${toString i}" = {
                action.move-window-to-workspace = [i];
                hotkey-overlay.title = "Move window to workspace ${toString i}";
              };
            }))
          ]);
      };
    };
  };
}
