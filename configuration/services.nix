{ user, ...} :
{
  services = {
    blueman.enable = true; # bluetooth manager
    fwupd.enable = true; # firmware updating service
    fstrim.enable = true; # ssd maintenance service
    thermald.enable = true; # thermal regulation service
    printing.enable = true; # printing services, cups
    upower.enable = true; # power management service
    flatpak.enable = true; # allow installing things from flatpaks
    power-profiles-daemon.enable = true; # power profiles

    # printer discovery
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };

  virtualisation.docker.enable = true; # enable docker
  users.users.${user.username}.extraGroups = [ "docker" ]; # add self to docker user group
}
