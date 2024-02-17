{ pkgs, lib, ... }:
let
  colors = {
    background = "#2E3440";
    foreground = "#ECEFF4";
    module = "#3B4252";
    disabled = "#4C566A";
    primary = "#8FBCBB";
    secondary = "#88C0D0";
    alert = "#BF616A";
    danger = "#D08770";
    warning = "#EBCB8B";
    good = "#A3BE8C";
    purple = "#B48EAD";
  };
  modules = import ./modules.nix colors;
in {
  home.file.".config/polybar/scripts/mute-dunst.sh" = {
    source = ./scripts/mute-dunst.sh;
    executable = true;
  };

  home.file.".config/polybar/scripts/mute-mic.sh" = {
    source = ./scripts/mute-mic.sh;
    executable = true;
  };

  services.polybar = {
    enable = true;
    package = (pkgs.polybar.override {
      i3Support = true;
      pulseSupport = true;
    });
    script = "";
    settings = lib.mkMerge [
      modules
      {
        "settings" = { screenchange.reload = true; };
        "section/base" = {
          wm.restack = "generic";
          background = colors.background;
          foreground = colors.foreground;
          line = {
            size = 3;
            color = "#ff00";
          };
          border.color = "#00000000";
          height = 25;
          padding = {
            left = 1;
            right = 1;
          };
          border = {
            top = {
              color = colors.background;
              size = 4;
            };
            bottom = {
              color = colors.background;
              size = 4;
            };
          };
          font = {
            "0" = "JetBrainsMono Nerd Font:size=10;3";
            "1" = "Iosevka Nerd Font:style=Medium:size=15;3";
            "2" = "JetBrainsMono Nerd Font:size=8;3";
            "3" = "Iosevka Nerd Font:style=Medium:size=12;3";
          };
          cursor = {
            click = "pointer";
            scroll = "ns-resize";
          };
        };
        "bar/secondary" = {
          "inherit" = "section/base";
          bottom = false;
          tray-position = "center";
          modules-left = "wired-ipv4 divider cpu divider memory";
        };
        "bar/primary" = {
          "inherit" = "section/base";
          bottom = false;
          modules-left = "open distro close divider i3";
          modules-right =
            "pulseaudio divider mute-mic mute-dunst divider open date time close";
        };
      }
    ];
  };
}
