{
  pkgs,
  system,
  inputs,
  lib,
  nixpkgs,
  username,
  nix-colors,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  colorScheme = nix-colors.colorSchemes.nord;

  home.username = username;

  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".default
    inputs.cursor-editor.packages."${system}".default
    discord
    jdk17
    prismlauncher
    steam
    tidal-hifi
    bitwarden
    gitkraken
    waybar
    nixfmt-rfc-style
    cliphist
    pinentry
    rofi-wayland
    bemoji
    blueman
    lmstudio
    gimp
    krita
    blender
    godot_4
    pinta
    filezilla
    stremio
    xarchiver
  ];

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    includes = [
      "~/.ssh/other_config"
    ];
  };

  services.easyeffects.enable = true;

  programs.git = {
    enable = true;
    userEmail = "me@wetrustinprize.com";
    userName = "wetrustinprize";
  };

  home.pointerCursor = {
    name = "phinger-cursors-light";
    package = pkgs.phinger-cursors;
    size = 32;
    gtk.enable = true;
    x11.enable = true;
  };

  services.swaync = {
    enable = true;
  };

  programs.waybar = {
    enable = true;
  };

  require = [
    ./waybar/waybar.nix
    ./hypr/hyprland.nix
    ./hypr/hyprpaper.nix
  ];

  home.stateVersion = "24.05";
}
