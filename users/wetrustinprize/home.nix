{ pkgs, lib, ... }:

{
  imports = [
    ./modules/alacritty.nix
    ./modules/dunst.nix
    ./modules/rofi.nix
    ./modules/i3/i3.nix
    ./modules/polybar/polybar.nix
    ./modules/developing.nix
    ./modules/gamming.nix
  ];

  programs.home-manager.enable = true;

  home.username = "wetrustinprize";
  home.homeDirectory = "/home/wetrustinprize";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    nitrogen
    vivaldi
    networkmanagerapplet
    volumeicon
    spotify
    qbittorrent
    vesktop
    (nerdfonts.override { fonts = [ "JetBrainsMono" "Iosevka" ]; })
    xorg.xkill
    xfce.thunar
  ];

  home.file.".background-image" = { source = ./background.png; };

  home.stateVersion = "23.11";
}
