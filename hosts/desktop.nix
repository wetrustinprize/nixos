{ pkgs, ... }: {
  security.polkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  services.xserver = {
    enable = true;
    displayManager = {
      lightdm = {
        enable = true;
        greeter.enable = true;
        greeters.mini = {
          enable = true;
          user = "wetrustinprize";
          extraConfig = ''
            [greeter]
            show-sys-info=true
            password-alignment = center

            [greeter-theme]
            font-weight = regular

            text-color=#eceff4
            error-color=#bf616a
            background-image = ""
            background-color = "#2e3440"

            window-color = "#4c566a"
            border-color = "#eceff4"
            border-width = 1px

            password-color = "#2e3440"
            password-background-color = "#eceff4"
            password-border-width = 0px
          '';
        };
      };
      defaultSession = "none+i3";
    };
    windowManager.i3 = { enable = true; };
  };

  programs.nix-ld.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
}
