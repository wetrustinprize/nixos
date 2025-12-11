{ pkgs, ... }: {
  # nixos desktop configuration
  environment.sessionVariables = {
    NIXOS_OZONE_WL="1";
  };

  # gnome keyring
  security.pam.services.gdm.enableGnomeKeyring = true;

  # privileges
  security.polkit.enable = true;

  # this is needed otherwise niri will freak out and lagg a lot
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };
  };

  # these extra portals allow for things like screen sharing
  xdg = {
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-wlr
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-gnome
      ];
    };
  };
}
