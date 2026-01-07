{ pkgs, config, lib, ... }: {
  home.packages = with pkgs; [
    xwayland-satellite
    nirius
  ];

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };

  programs.niri = {
    settings = {
      prefer-no-csd = true;

      spawn-at-startup = lib.mkAfter [{
        argv = ["tailscale" "systray"];
      } {
        argv = ["niriusd"];
      }];

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
          matches = [ # matches for swaybg
            { namespace = "^wallpaper$"; }
          ];

          place-within-backdrop = true;
        }
      ];

      window-rules = [
        { # global window rules
          clip-to-geometry = true;
          geometry-corner-radius = {
            top-left = 8.0;
            top-right = 8.0;
            bottom-left = 8.0;
            bottom-right = 8.0;
          };
        }
        {
          matches = [ # matches for blocking in screensharing
            { app-id = "Bitwarden"; }
            { app-id = "Thunderbird"; }
            { app-id = "org.nickvision.money"; }
            { app-id = "firefox$"; title = ".*Fastmail.*"; }
          ];

          block-out-from = "screencast";
        }
        {
          matches = [ # matches for opening floating windows
            { app-id = "Alacritty"; }
            { app-id = "Bitwarden"; }
            { app-id = "org.pulseaudio.pavucontrol"; }
            { app-id = "io.gitlab.idevecore.Pomodoro"; }
          ];

          open-floating = true;
        }
        {
          matches = [ # matches for firefox pip window
            { app-id = "firefox$"; title = "^Picture-in-Picture"; }
          ];

          default-column-width.fixed = 480;
          default-window-height.fixed = 270;
          open-floating = true;
        }
      ];

      binds =
        let
          foreachWorkspace = fn: pkgs.lib.map (i: fn i) (pkgs.lib.range 1 9);
        in
        pkgs.lib.attrsets.mergeAttrsList ( pkgs.lib.flatten [
          {
            "Mod+T" = {
              action.spawn = ["alacritty"];
              hotkey-overlay.title = "Spawn terminal";
            };
            "Mod+Shift+Slash" = {
              action.show-hotkey-overlay = [];
            };
            "Mod+Q" = {
              action.close-window = [];
              repeat = false;
            };
            "Mod+O" = {
              action.spawn = ["nirius" "focus-or-spawn" "--app-id=obsidian" "obsidian"];
              hotkey-overlay.title = "Spawn or focus Obsidian";
            };
            "Mod+B" = {
              action.spawn = ["nirius" "focus-or-spawn" "--app-id=bitwarden" "bitwarden"];
              hotkey-overlay.title = "Spawn or focus Bitwarden";
            };
            "Mod+Space" = {
              action.toggle-overview = [];
            };
            "Mod+W" = {
              action.toggle-column-tabbed-display = [];
            };
            "Mod+Shift+E" = {
              action.quit = [];
            };
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
            "Mod+F" = {
              action.fullscreen-window = [];
            };
            "Print" = {
              action.screenshot = [];
            };
            "Ctrl+Print" = {
              action.screenshot-screen = [];
            };
            "Shift+Print" = {
              action.screenshot-window = [];
            };
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
              action.focus-workspace = [ i ];
              hotkey-overlay.title = "Go to workspace ${toString i}";
            };
          }))
          (foreachWorkspace (i: {
            "Mod+Ctrl+${toString i}" = {
              action.move-column-to-workspace = [ i ];
              hotkey-overlay.title = "Move column to workspace ${toString i}";
            };
          }))
          (foreachWorkspace (i: {
            "Mod+Shift+${toString i}" = {
              action.move-window-to-workspace = [ i ];
              hotkey-overlay.title = "Move window to workspace ${toString i}";
            };
          }))
        ]);
    };
  };
}
