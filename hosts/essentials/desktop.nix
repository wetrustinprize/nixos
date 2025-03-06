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

  fonts.packages = with pkgs; [ nerdfonts ];

  services.displayManager.ly = {
    enable = true;
    settings = {
      "clear_password" = true;
      "vi_mode" = true;
    };
  };

  environment.systemPackages = with pkgs; [
    kitty
    egl-wayland
    gparted
    wl-clipboard-rs
    playerctl
    steam-run
  ];
}
