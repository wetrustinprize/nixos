{ pkgs, ... }:

{
  imports = [
    ./modules/alacritty.nix
    ./modules/dunst.nix
    ./modules/rofi/rofi.nix
    ./modules/i3/i3.nix
    ./modules/polybar/polybar.nix
  ];

  nixpkgs.config.allowUnfreePredicate = _: true;

  programs.home-manager.enable = true;

  home.username = "wetrustinprize";
  home.homeDirectory = "/home/wetrustinprize";

  home.packages = with pkgs; [
    nitrogen
    vscode
    vivaldi
    networkmanagerapplet
    volumeicon
    spotify
    qbittorrent
    (nerdfonts.override { fonts = [ "JetBrainsMono" "Iosevka" ]; })

    xorg.xkill

    xfce.thunar
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.
}
