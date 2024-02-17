{ pkgs, lib, ... }:

{
  imports = [
    ./modules/alacritty.nix
    ./modules/dunst.nix
    ./modules/rofi.nix
    ./modules/i3/i3.nix
    ./modules/polybar/polybar.nix
  ];

  programs.home-manager.enable = true;

  home.username = "wetrustinprize";
  home.homeDirectory = "/home/wetrustinprize";

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "vscode" ];

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
