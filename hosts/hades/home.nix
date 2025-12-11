{ pkgs, ... }: {
  imports = [
    ../../home
  ];

  programs.waybar.settings.mainBar = {
    output = [ "eDP-1" ];
    modules-left = pkgs.lib.mkAfter [
      "cpu"
      "memory"
      "battery"
    ];
    battery = {
      bat = pkgs.lib.mkForce "BAT0";
    };
  };

  # wayland.windowManager.hyprland.settings = {
  #   monitor = [
  #     "eDP-1, highres@highrr, 0x0, 1.25"
  #     ", preferred, auto, 1, mirror, eDP-1"
  #   ];
  #   workspace = pkgs.lib.map (i: "${toString i}, monitor:eDP-1") (pkgs.lib.range 1 9);
  #   input = {
  #     kb_layout = "br";
  #     kb_variant = "thinkpad";
  #   };
  # };
}
