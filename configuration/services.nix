{ user, ...} :
{
  services = {
    blueman.enable = true; # bluetooth manager
    fwupd.enable = true; # firmware updating service
    fstrim.enable = true; # ssd maintenance service
    thermald.enable = true; # thermal regulation service
    printing.enable = true; # printing services, cups
    upower.enable = true; # power management service
    power-profiles-daemon.enable = true; # power profiles

    # tailscale vpn
    tailscale = {
      enable = true;
      extraSetFlags = [ "--operator=${user.username}" ];
    };
  };

  virtualisation.docker.enable = true; # enable docker
  users.users.${user.username}.extraGroups = [ "docker" ]; # add self to docker user group
}
