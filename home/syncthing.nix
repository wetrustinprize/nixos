{ ... }: {
  sops.secrets."syncthing-password".path = "%r/syncthing-password";

  services.syncthing = {
    enable = true;
    tray.enable = true;
  };
}
