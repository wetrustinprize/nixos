{ ... }:
let
  modifier = "Mod4";
  unfocusedColor = {
    border = "#2e3440";
    background = "#1f222d";
    text = "#888888";
    indicator = "#1f222d";
    childBorder = "#2e3440";
  };
in {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      inherit modifier;

      startup = [{
        command = "polybar --reload primary";
        notification = false;
      }];

      bars = [ ]; # use polybar instead

      fonts = { names = [ "JetBrainsMono Nerd Font Mono" ]; };

      workspaceAutoBackAndForth = true;

      window = {
        hideEdgeBorders = "none";
        border = 1;
        titlebar = false;
      };

      startup = [
        {
          command = "nitrogen --restore";
          notification = false;
        }
        {
          command = "volumeicon";
          notification = false;
        }
        {
          command = "nm-applet";
          notification = false;
        }
      ];

      floating = {
        inherit modifier;
        border = 1;
        titlebar = false;
      };

      colors = {
        focused = {
          border = "#81a1c1";
          background = "#81a1c1";
          text = "#ffffff";
          indicator = "#81ac1";
          childBorder = "#81a1c1";
        };
        urgent = {
          border = "#900000";
          background = "#900000";
          text = "#ffffff";
          indicator = "#900000";
          childBorder = "#900000";
        };
        unfocused = unfocusedColor;
        focusedInactive = unfocusedColor;
        placeholder = unfocusedColor;
        background = "#242424";
      };

      gaps = {
        inner = 12;
        outer = 0;
        smartBorders = "on";
      };

      keybindings = import ./i3-keybindings.nix modifier;
    };
  };
}
