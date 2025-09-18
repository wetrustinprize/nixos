{
  pkgs,
  inputs,
  nix-colors,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    # browsers
    inputs.zen-browser.packages."${system}".default
    chromium

    # productivity
    libreoffice
    obsidian
    qalculate-qt
    mission-center

    # chat
    discord

    # password manager
    bitwarden

    # media
    spotify
    playerctl # cli for media players
    qbittorrent
    obs-studio
    kooha
    vlc

    # windows
    bottles

    # desktop
    cliphist
    blueman
    fm # simple file manager
    mucommander # split file manager
    xarchiver
    pavucontrol
    gparted
    wl-clipboard
    egl-wayland
    gnome-keyring

    # image editing
    gimp
  ];

  gtk.theme.package = nix-colors.gtk-theme config.colorScheme;

  # FIXME: Look after why Git Kraken is so bad at wayland
  xdg.desktopEntries."GitKraken Desktop" = {
    categories = [ "Development" ];
    comment = "Unleash your repo";
    exec = "gitkraken --ozone-platform=x11";
    genericName = "Git Client";
    icon = "gitkraken";
    name = "GitKraken Desktop";
    type = "Application";
  };

  home.pointerCursor = {
    name = "phinger-cursors-light";
    package = pkgs.phinger-cursors;
    size = 32;
    gtk.enable = true;
    x11.enable = true;
  };

  require = [
    ./modules/waybar/waybar.nix
    ./modules/hypr/hyprland.nix
    ./modules/hypr/hyprpaper.nix
    ./modules/hypr/hypridle.nix
    ./modules/hypr/hyprpolkit.nix
    ./modules/hypr/hyprsunset.nix
    ./modules/kando.nix
    ./modules/kitty.nix
    ./modules/rofi/rofi.nix
    ./modules/swaync/swaync.nix
    ./modules/mangohud.nix
    ./modules/sticky-notes.nix
    ./modules/vscode.nix
  ];
}
