{ user, pkgs, config, ... }: {
  imports = [
    ./boot.nix
    ./shell.nix
    ./audio.nix
    ./files.nix
    ./locale.nix
    ./login.nix
    ./networking.nix
    ./nix-settings.nix
    ./services.nix
    ./steam.nix
    ./sops.nix
    ./stylix.nix
    ./niri.nix
  ];

  sops.secrets."user-password".neededForUsers = true;

  users.mutableUsers = true;
  users.users.${user.username} = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets."user-password".path;
    extraGroups = [
      "wheel" # can sudo
    ];
  };

  environment.systemPackages = with pkgs; [
    neovim # terminal file editing
    wget # fetch util
    curl # fetch util
    git # version control
    tldr # fast way to understand cli commands
    lm_sensors # temperature sensors util
    caligula # disk flashing util
    htop # process monitoring
    croc # file transfering
    dysk # disk management util
    nano # terminal file editing
    bat # terminal file viewing
    brightnessctl # screen brightness control
    dmidecode # hardware info
    pay-respects # command correction
    lsof # list open files, useful for port debugging
    nmap # map ports of an address
  ];

  programs = {
    nix-ld.enable = true;   # helps with linking troubles with dynamic libraries
    appimage.enable = true; # allow appimage installations
    gnupg.agent = {
      # pgp client
      enable = true;
      enableSSHSupport = true;
    };
  };

  system.stateVersion = user.stateVersion;
}
