{ pkgs, ... }: {
  imports = [
    ./easyeffects.nix
  ];

  # nixos desktop configuration
  environment.sessionVariables = {
    NIXOS_OZONE_WL="1";
  };

  # gnome keyring
  security.pam.services.gdm.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true; # keyring

  # privileges
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    # fallback icon themes for gtk application
    papirus-icon-theme
    hicolor-icon-theme
    adwaita-icon-theme
    kdePackages.breeze-icons
  ];

  # this is needed otherwise niri will freak out and lagg a lot
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };
  };
}
