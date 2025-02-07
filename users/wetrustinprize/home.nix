{
  pkgs,
  system,
  inputs,
  lib,
  nixpkgs,
  username,
  nix-colors,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  colorScheme = nix-colors.colorSchemes.nord;

  home.username = username;

  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".default
    inputs.cursor-editor.packages."${system}".default
    discord
    jdk17
    prismlauncher
    steam
    tidal-hifi
    bitwarden
    gitkraken
    waybar
    nixfmt-rfc-style
    cliphist
    pinentry
    rofi-wayland
    bemoji
    blueman
  ];

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    includes = [
      "~/.ssh/other_config"
    ];
  };

  programs.git = {
    enable = true;
    userEmail = "me@wetrustinprize.com";
    userName = "wetrustinprize";
  };

  home.pointerCursor = {
    name = "Nordzy-cursors";
    package = pkgs.nordzy-cursor-theme;
  };

  programs.waybar = {
    enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "waybar"
        "wl-paste --type text --watch cliphist store # Stores only text data"
        "wl-paste --type image --watch cliphist store # Stores only image data"
      ];
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$browser" = "zen";
      "$visual" = "cursor";
      "$explorer" = "thunar";
      general = {
        "allow_tearing" = true;
		"gaps_out" = "10 20 20 20";
      };
      monitor = [
        "DP-1, highres@highrr, 1080x0, 1"
        "HDMI-A-1, highres@highrr, 0x-540, 1, transform, 1"
        ", preferred, auto, 1, mirror, DP-1"
      ];
      bind =
        [
          "$mod, T, exec, $terminal"
          "$mod, B, exec, $browser"
          "$mod, SPACE, togglefloating,"
          "$mod SHIFT, C, killactive,"
          "$mod, r, exec, reload"
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"
          "$mod, e, exec, $visual"
          "$mod, f, fullscreen,"
          "$mod, tab, pin"
          "$mod, x, exec, $explorer"

          # rofi stuff
          "$mod, p, exec, rofi -show drun -p Run"
          "$mod SHIFT, p, exec, rofi -show run -p Run"
          "$mod, V, exec, cliphist list | rofi -dmenu -p Copy | cliphist decode | wl-copy"
          "$mod, o, exec, bemoji"
        ]
        ++ lib.map (i: "$mod, ${toString i}, workspace, ${toString i}") (lib.range 1 9)
        ++ lib.map (i: "$mod SHIFT, ${toString i}, movetoworkspace, ${toString i}") (lib.range 1 9);
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      workspace = [
        "10, monitor:HDMI-A-1"
      ] ++ lib.map (i: "${toString i}, monitor:DP-1") (lib.range 1 9);
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        "float,class:^($terminal)$,title:^($terminal)$"
      ];
    };
    extraConfig = ''
      env = LIBVA_DRIVER_NAME,nvidia
      env = __GLX_VENDOR_LIBRARY_NAME,nvidia
      env = NVD_BACKEND,direct
      env = ELECTRON_OZONE_PLATFORM_HINT,auto
      debug:disable_logs = false
    '';
  };

  require = [ ./waybar/waybar.nix ];

  home.stateVersion = "24.05";
}
