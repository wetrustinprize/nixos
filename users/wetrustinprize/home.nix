{ pkgs, ... }:

{
  imports = [
    ./modules/i3/i3.nix
    ./modules/alacritty.nix
    ./modules/polybar/polybar.nix
  ];

  nixpkgs.config.allowUnfreePredicate = _: true;

  home.username = "wetrustinprize";
  home.homeDirectory = "/home/wetrustinprize";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    nitrogen
    vscode
    vivaldi
    networkmanagerapplet
    volumeicon
    rofi
    spotify
    qbittorrent
    (nerdfonts.override { fonts = [ "JetBrainsMono" "Iosevka" ]; })

    xorg.xkill

    xfce.thunar
  ];

  home.file = { };

  home.sessionVariables = { };

  programs.home-manager.enable = true;
}
