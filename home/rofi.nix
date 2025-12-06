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

  wayland.windowManager.hyprland.settings.bind = [
    "$mod, P, exec, rofi -show drun"
    "$mod SHIFT, P, exec, rofi -show run"

    "$mod, E, exec, bemoji"
    "$mod, W, exec, rofi -show window"

    "$mod, C, exec, rofi -show calc"
  ];
}
