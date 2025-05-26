{
  pkgs,
  inputs,
  nix-colors,
  config,
  ...
}:
{
  nixpkgs = {
    overlays = [
      inputs.blender-bin.overlays.default
    ];
  };

  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".default
    chromium
    libreoffice
    discord
    jdk17
    lutris
    prismlauncher
    steam
    bitwarden
    spotify
    gitkraken
    waybar
    cliphist
    blueman
    gimp
    krita
    blender_4_4
    godot_4
    pinta
    filezilla
    stremio
    xarchiver
    obsidian
    pavucontrol
    egl-wayland
    gparted
    wl-clipboard
    playerctl
    steam-run
    hyprshot
    hyprpaper
    gamemode
    gamescope
    protonup
    qbittorrent
    obsidian
    kooha
    obs-studio
    mucommander
    gnome-keyring
    dbeaver-bin
    bruno
    bruno-cli
    fm
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
    ./modules/kando.nix
    ./modules/kitty.nix
    ./modules/rofi/rofi.nix
    ./modules/swaync/swaync.nix
    ./modules/mangohud.nix
    ./modules/sticky-notes.nix
    ./modules/vscode.nix
  ];
}
