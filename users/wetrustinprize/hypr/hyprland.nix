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
        "[workspace special:calculator] qalculate-gtk"
        "[worksapce special:password] bitwarden"
        "[workspace name:side-monitor] discord"
        "sleep 10 && megasync"
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
      monitor = [
        "DP-1, highres@highrr, 1080x0, 1"
        "HDMI-A-1, highres@highrr, 0x-540, 1, transform, 1"
        ", preferred, auto, 1, mirror, DP-1"
      ];
      bind =
        [
          # launch apps
          "$mod, RETURN, exec, [float, center, size 16 16] $terminal"
          "$mod, F1, exec, $browser"
          "$mod, F2, exec, $visual"
          "$mod, F3, exec, $terminal yazi"

          "$mod, C, exec, pgrep qalculate-gtk && hyprctl dispatch togglespecialworkspace calculator || qalculate-gtk &"
          "$mod, B, exec, pgrep -f bitwarden-desktop && hyprctl dispatch togglespecialworkspace password || bitwarden &"

          # window management
          "$mod SHIFT, SPACE, togglefloating,"
          "$mod SHIFT, C, killactive,"
          "$mod SHIFT, TAB, pin"

          # layout
          "$mod, f, fullscreen,"
          "$mod, t, togglegroup,"

          "$mod, r, exec, reload"
          "$mod SHIFT, Q, exec, exit"

          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"

          # rofi stuff
          "$mod, p, exec, rofi -show drun -p Run"
          "$mod, V, exec, cliphist list | rofi -dmenu -p Copy | cliphist decode | wl-copy"
          "$mod, o, exec, bemoji"

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
      workspace = [
        "name:side-monitor, monitor:HDMI-A-1"
        "special:calculator, monitor:DP-1"
        "special:password, monitor:DP-1"
      ] ++ lib.map (i: "${toString i}, monitor:DP-1") (lib.range 1 9);
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        "float,class:(qalculate-gtk)"
        "float,class:(Bitwarden)"
        "float,class:(MEGAsync)"
        "float,class:(.blueman-manager-wrapped)"
        "float,class:(org.pulseaudio.pavucontrol)"
        "float,class:(com.github.wwmm.easyeffects)"
        "float,title:Picture-in-Picture"
        "workspace special:calculator,class:(qalculate-gtk)"
        "workspace special:password,class:(Bitwarden)"
        "workspace name:side-monitor,class:(discord)"
      ];
    };
    extraConfig = ''
            env = LIBVA_DRIVER_NAME,nvidia
            env = __GLX_VENDOR_LIBRARY_NAME,nvidia
            env = NVD_BACKEND,direct
            env = ELECTRON_OZONE_PLATFORM_HINT,auto
      	  env = EDITOR,vim
            debug:disable_logs = false
    '';
  };
}
