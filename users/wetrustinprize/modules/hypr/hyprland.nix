{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    hyprpaper
    hyprshot
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    plugins = [
      inputs.hypr-dynamic-cursors.packages.${pkgs.system}.hypr-dynamic-cursors
      inputs.hyprland-easymotion.packages.${pkgs.system}.hyprland-easymotion
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprexpo
    ];
    settings = {
      exec-once = [
        "hyprpaper"
        "waybar"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "hyprctl setcursor phinger-cursors-light 32"
        "[worksapce special:password] bitwarden"
        "[workspace special:obsidian] obsidian"
      ];
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$browser" = "zen";
      "$editor" = "vim";
      "$visual" = "cursor";
      "plugin:dynamic-cursors" = {
        "shaperule" = [
          "text, none"
          "vertical_text, none"
          "crosshair, none"
        ];
        "tilt" = {
          "limit" = 10000;
        };
        "shake" = {
          "enabled" = false;
        };
      };
      "plugin:easymotion" = {
        "bgcolor" = "rgb(${config.colorScheme.palette.base01})";
        "bordercolor" = "rgb(${config.colorScheme.palette.base06})";
        "bordersize" = "1";
        "textcolor" = "rgb(${config.colorScheme.palette.base06})";
        "textpadding" = "20 20 20 20";
      };
      "plugin:hyprexpo" = {
        "workspace_method" = "first 1";
        "skip_empty" = true;
      };
      misc = {
        disable_hyprland_logo = true;
      };
      ecosystem = {
        no_donation_nag = true;
        no_update_news = true;
      };
      general = {
        "allow_tearing" = true;
        "gaps_out" = 10;
        "col.inactive_border" = "rgb(${config.colorScheme.palette.base01})";
        "col.active_border" = "rgb(${config.colorScheme.palette.base06})";

        snap = {
          enabled = true;
        };
      };
      decoration = {
        rounding = 5;
        inactive_opacity = 0.95;
        active_opacity = 1.00;

        blur = {
          enabled = true;
          size = 10;
          passes = 2;
          new_optimizations = true;
          ignore_opacity = true;
          brightness = 0.90;
        };
      };
      bezier = [
        "easeOutQuart, 0.25, 1, 0.5, 1"
        "linear, 0, 0, 1, 1"
      ];
      animation = [
        "workspaces, 1, 2, easeOutQuart"
        "windowsIn, 1, 2, easeOutQuart"
        "windowsMove, 1, 1, easeOutQuart"
        "windowsOut, 1, 2, linear, gnomed"
        "fadeOut, 1, 1, easeOutQuart"
      ];
      group = {
        groupbar = {
          "col.inactive" = "rgb(${config.colorScheme.palette.base01})";
          "col.active" = "rgb(${config.colorScheme.palette.base0F})";
        };
      };
      gesture = [
        "3, horizontal, workspace"
      ];
      bind = [
        # launch apps
        "$mod, RETURN, exec, [float; center; size 730 470] $terminal"

        "$mod, B, exec, pgrep -f bitwarden-desktop && hyprctl dispatch togglespecialworkspace password || bitwarden &"
        "$mod, O, exec, pgrep -f obsidian && hyprctl dispatch togglespecialworkspace obsidian || obsidian &"

        # window management
        "$mod SHIFT, SPACE, togglefloating,"
        "$mod SHIFT, C, killactive,"
        "$mod SHIFT, TAB, pin"
        "$mod SHIFT, W, hyprexpo:expo, toggle"
        "$mod, SPACE, easymotion, action:hyprctl dispatch focuswindow address:{}"

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
      xwayland {
        force_zero_scaling = true
      }
    '';
  };
}
