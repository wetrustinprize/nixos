{ pkgs, inputs, ... }:
{
  imports = [ ./desktop.nix ];

  nix.settings = {
    # add the hyprland cache so that we dont build hyprland from source
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # we use uwsm to manage launching hyprland
  # uswm will add hyprland to the login sessions with tuigreet.
  programs = {
    uwsm.enable = true;
    uwsm.waylandCompositors = {
      hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/Hyprland";
      };
    };

    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      withUWSM  = true;
      xwayland.enable = true;
    };
  };

  # this is a lot of env vars.
  # and this requires some cleanup
  # but hyprland moves fast and some of these are probably outdated already
  environment.sessionVariables = {
    XDG_SESSION_TYPE="wayland";
    XDG_CURRENT_DESKTOP="Hyprland";
    XDG_SESSION_DESKTOP="Hyprland";
  };

  # allow hyprlock (lockscreen) to lock user session
  security.pam.services.hyprlock = { };
}
