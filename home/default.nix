{ user, pkgs, ... }: {
  imports = [
    ./terminal.nix
    ./zed.nix
    ./rofi.nix
    ./waybar
    ./hyprland.nix
    ./browser.nix
    ./sticky-notes.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    bitwarden-desktop # password control
    bitwarden-cli # password control but cli
    obsidian # markdown notes app
    discord # gaming communication app
    slack # work communication app
    clickup # work task management app
    prismlauncher # minecraft launcher
    gitkraken # better git control
    spotify # music player
    gimp # image manipulation
    krita # drawing app
    blender # 3D modelling
    godot # game engine
    unityhub # unity game engine manager
    audacity # audio manipulation
    libreoffice # office suite
    inkscape # vector graphics editor
    bottles # easier wine
    beeper # better way to use many communication apps
  ];

  home.username = "${user.username}";
  home.homeDirectory = pkgs.lib.mkDefault "/home/${user.username}";
  home.stateVersion = user.stateVersion;
}
