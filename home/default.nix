{ user, pkgs, ... }: {
  imports = [
    ./terminal.nix
    ./zed.nix
    ./browser.nix
    ./sticky-notes.nix
    ./mail.nix
    ./sops.nix
    ./niri.nix
    ./spicetify.nix
    ./nixcord.nix
    ./easyeffects.nix
    ./noctalia.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    bitwarden-desktop # password control
    bitwarden-cli # password control but cli
    obsidian # markdown notes app
    slack # work communication app
    prismlauncher # minecraft launcher
    gitkraken # better git control
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
    gamescope # game x11
    gnucash # finance app
    pavucontrol # pulse audio control
  ];

  home.username = "${user.username}";
  home.homeDirectory = pkgs.lib.mkDefault "/home/${user.username}";
  home.stateVersion = user.stateVersion;
}
