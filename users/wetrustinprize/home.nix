{
  pkgs,
  system,
  inputs,
  lib,
  nixpkgs,
  username,
  nix-colors,
  config,
  ...
}:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      inputs.nix-your-shell.overlays.default
    ];
  };

  colorScheme = nix-colors.colorSchemes.nord;

  home.username = username;

  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".default
    inputs.cursor-editor.packages."${system}".default
    chromium
    libreoffice
    discord
    jdk17
    lutris
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
    gimp
    krita
    blender
    godot_4
    pinta
    filezilla
    stremio
    xarchiver
	qalculate-gtk
	obsidian
	megasync
	pavucontrol
	hyprpolkitagent
  ];

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    includes = [
      "~/.ssh/other_config"
    ];
  };

  programs.nushell = {
    enable = true;
	shellAliases = {
		"?" = "question";
	};
	extraConfig = "source nix-your-shell.nu";
  };
  home.file."${config.xdg.configHome}/nushell/nix-your-shell.nu".source =
    pkgs.nix-your-shell.generate-config "nu";

  services.easyeffects.enable = true;

  programs.git = {
    enable = true;
    userEmail = "me@wetrustinprize.com";
    userName = "wetrustinprize";
  };

  gtk.theme.package = nix-colors.gtk-theme config.colorScheme;

  home.pointerCursor = {
    name = "phinger-cursors-light";
    package = pkgs.phinger-cursors;
    size = 32;
    gtk.enable = true;
    x11.enable = true;
  };

  programs.waybar = {
    enable = true;
  };

  require = [
    ./waybar/waybar.nix
    ./hypr/hyprland.nix
    ./hypr/hyprpaper.nix
    ./starship.nix
    ./kitty.nix
	./swaync/swaync.nix
  ];

  home.stateVersion = "24.05";
}
