{ pkgs, lib, ... }:

{
  imports = [
    ./modules/shell/bash.nix
  ];

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "Peterson Adami Candido";
    userEmail = "me@wetrustinprize.com";
  };

  home.username = "wetrustinprize";
  home.homeDirectory = "/home/wetrustinprize";

  xsession.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    nitrogen
    networkmanagerapplet
    volumeicon
    spotify
    qbittorrent
    vesktop
    (nerdfonts.override { fonts = [ "JetBrainsMono" "Iosevka" ]; })
    xorg.xkill
    xfce.thunar
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    iconTheme = {
      name = "Nordzy-icon";
      package = pkgs.nordzy-icon-theme;
    };
  };

  services.easyeffects = {
      enable = true;
  }

  home.pointerCursor = {
    name = "Nordzy-cursors";
    package = pkgs.nordzy-cursor-theme;
  };

  home.file.".background-image" = { source = ./background.png; };

  home.stateVersion = "24.05";
}
