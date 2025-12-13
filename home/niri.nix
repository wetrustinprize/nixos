{ pkgs, ... }: {
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

      spawn-at-startup = [
        { argv = ["niriusd"]; }
      ];

      input = {
        focus-follows-mouse.enable = true;
        workspace-auto-back-and-forth = true;
      };

      gestures = {
        hot-corners.enable = false;
      };

      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      hotkey-overlay = {
        hide-not-bound = true;
      };

      window-rules = [
        {
          matches = [ { app-id = "Bitwarden"; } ];
          open-floating = true;
          block-out-from = "screencast";
        }
        {
          matches = [ { app-id = "Alacritty"; } ];
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
            "Mod+O" = {
              action.toggle-overview = [];
              repeat = false;
            };
            "Mod+Q" = {
              action.close-window = [];
              repeat = false;
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
