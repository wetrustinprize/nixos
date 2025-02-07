{ pkgs, system, inputs, lib, nixpkgs, username, ... }: { 
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".default
    inputs.cursor-editor.packages."${system}".default
    discord
    jdk17
    prismlauncher
    steam
    tidal-hifi
    bitwarden
    bitwarden-cli
    walker
    gitkraken
  ];

  home.file.ssh_ed25519_key = {
    source = "/etc/ssh/ssh_${username}_ed25519_key";
    target = ".ssh/ssh_ed25519_key";
  };

  programs.ssh.enable = true;

  programs.git = {
    enable = true;
    userEmail = "me@wetrustinprize.com";
    userName = "wetrustinprize";
  };

  home.pointerCursor = {
    name = "Nordzy-cursors";
    package = pkgs.nordzy-cursor-theme;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$browser" = "zen";
      "$visual" = "cursor";
      "$explorer" = "thunar";
      general = {
        "allow_tearing" = true;
      };
      monitor = [
        "DP-1, highres@highrr, 1080x0, 1"
        "HDMI-A-1, highres@highrr, 0x-540, 1, transform, 1"
        ", preferred, auto, 1, mirror, DP-1"
      ];
      bind = [ 
        "$mod, T, exec, $terminal"
        "$mod, B, exec, $browser"
        "$mod, SPACE, togglefloating,"
        "$mod SHIFT, C, killactive,"
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
        "$mod, e, exec, $visual"
        "$mod, f, fullscreen,"
        "$mod, tab, pin"
        "$mod, x, exec, $explorer"
        # temporary app launcher
        "$mod, p, exec, walker"
      ]
      ++ lib.map (i: "$mod, ${toString i}, workspace, ${toString i}") (lib.range 1 9)
      ++ lib.map (i: "$mod SHIFT, ${toString i}, movetoworkspace, ${toString i}") (lib.range 1 9);
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      workspace = [
        "10, monitor:HDMI-A-1"
      ]
      ++ lib.map (i: "${toString i}, monitor:DP-1") (lib.range 1 9);
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

  home.stateVersion = "24.05";
}
