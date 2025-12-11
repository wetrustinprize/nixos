{ pkgs, ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      rofimoji = prev.rofi-calc.override { rofi = prev.rofi-wayland; };
    })
  ];

  home.packages = with pkgs; [
    bemoji
  ];

  programs.rofi = {
    enable = true;
    plugins = with pkgs; [ rofi-calc ];
  };

  programs.niri.settings.binds = {
    "Mod+P" = {
      action.spawn-sh = "rofi -show drun";
      hotkey-overlay.title = "Run application";
    };

    "Mod+C" = {
      action.spawn-sh = "rofi -show calc";
      hotkey-overlay.title = "Rofi calculator";
    };

    "Mod+Period" = {
      action.spawn-sh = "bemoji";
      hotkey-overlay.title = "Rofi select emoji";
    };
  };

  wayland.windowManager.hyprland.settings.bind = [
    "$mod, P, exec, rofi -show drun"
    "$mod SHIFT, P, exec, rofi -show run"

    "$mod, E, exec, bemoji"
    "$mod, W, exec, rofi -show window"

    "$mod, C, exec, rofi -show calc"
  ];
}
