{
  lib,
  pkgs,
  config,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [ ];
    settings = {
      exec-once = [
        "hyprpaper"
        "waybar"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "hyprctl setcursor phinger-cursors-light 32"
        "[worksapce special:password] bitwarden"
        "[workspace name:side-monitor] discord"
        "[workspace special:obsidian] obsidian"
      ];
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$browser" = "zen";
      "$editor" = "vim";
      "$visual" = "cursor";
      general = {
        "allow_tearing" = true;
        "gaps_out" = 10;
        "col.inactive_border" = "rgb(${config.colorScheme.palette.base01})";
        "col.active_border" = "rgb(${config.colorScheme.palette.base06})";
      };
      group = {
        groupbar = {
          "col.inactive" = "rgb(${config.colorScheme.palette.base01})";
          "col.active" = "rgb(${config.colorScheme.palette.base0F})";
        };
      };
      bind =
        [
          # launch apps
          "$mod, RETURN, exec, [float; center; size 730 470] $terminal"
          "$mod, F1, exec, $browser"
          "$mod, F2, exec, $visual"
          "$mod, F3, exec, $terminal yazi"

          "$mod, B, exec, pgrep -f bitwarden-desktop && hyprctl dispatch togglespecialworkspace password || bitwarden &"
          "$mod, O, exec, pgrep -f obsidian && hyprctl dispatch togglespecialworkspace obsidian || obsidian &"

          # window management
          "$mod SHIFT, SPACE, togglefloating,"
          "$mod SHIFT, C, killactive,"
          "$mod SHIFT, TAB, pin"

          # layout
          "$mod, f, fullscreen,"
          "$mod, t, togglegroup,"
          "$mod shift, t, moveoutofgroup"

          "$mod, r, exec, reload"
          "$mod SHIFT, Q, exec, exit"

          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"

          # movement
          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"
          "$mod, tab, changegroupactive, f"

          # move window
          "$mod shift, h, movewindow, l"
          "$mod shift, l, movewindow, r"
          "$mod shift, k, movewindow, u"
          "$mod shift, j, movewindow, d"

          # screenshot
          ", Print, exec, hyprshot -m region --clipboard-only"
        ]
        ++ lib.map (i: "$mod, ${toString i}, workspace, ${toString i}") (lib.range 1 9)
        ++ lib.map (i: "$mod SHIFT, ${toString i}, movetoworkspace, ${toString i}") (lib.range 1 9);
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        "float,class:(Bitwarden)"
        "float,class:(.blueman-manager-wrapped)"
        "float,class:(org.pulseaudio.pavucontrol)"
        "float,title:Picture-in-Picture"
        "float,title:Open Files"
        "workspace special:password,class:(Bitwarden)"
        "workspace special:obsidian,class:(obsidian)"
        "workspace name:side-monitor,class:(discord)"
      ];
    };
    extraConfig = ''
            env = LIBVA_DRIVER_NAME,nvidia
            env = __GLX_VENDOR_LIBRARY_NAME,nvidia
            env = NVD_BACKEND,direct
            env = ELECTRON_OZONE_PLATFORM_HINT,auto
            env = EDITOR,vim
      	  env = NIXOS_OZONE_WL,1
            debug:disable_logs = false
    '';
  };
}
