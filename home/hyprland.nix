{ lib, pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    hyprshot
  ];

  services.hyprpolkitagent.enable = true;
  wayland.windowManager.hyprland.systemd.enable = false;

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    settings = {
      exec-once = [
        "waybar"
        "[worksapce special:password] bitwarden"
        "[workspace special:obsidian] obsidian"
      ];
      "$mod" = "SUPER";
      "$terminal" = "alacritty";
      "$browser" = "zen";
      "$editor" = "vim";
      "$visual" = "zed";
      misc = {
        disable_hyprland_logo = true;
      };
      ecosystem = {
        no_donation_nag = true;
        no_update_news = true;
      };
      workspace = lib.map (i: "${toString i}, monitor:DP-1") (lib.range 1 9);
      general = {
        "allow_tearing" = true;
        "gaps_out" = 10;
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
