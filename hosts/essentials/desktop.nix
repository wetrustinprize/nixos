{ inputs, pkgs, ... }:
{
  programs.hyprland.enable = true;

  programs.thunar = {
    enable = true;
    plugins = [
      pkgs.xfce.thunar-archive-plugin
    ];
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  security.polkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  fonts.packages = with pkgs; [ nerdfonts ];

  environment.systemPackages = with pkgs; [
    kitty
    egl-wayland
    gparted
    wl-clipboard-rs
    playerctl
    steam-run
  ];
}
