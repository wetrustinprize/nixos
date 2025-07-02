{
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ../common.nix
    ../virtualization.nix
    ../ai.nix

    ./containers/cloudflared/cloudflared.nix
    ./containers/pihole/pihole.nix
    ./containers/traefik/traefik.nix
    ./containers/foundryvtt/foundryvtt.nix
    ./containers/filebrowser/filebrowser.nix
    ./containers/homepage/homepage.nix
    ./containers/actual.nix
    ./containers/qbittorrent.nix
    ./containers/glances.nix

    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "atena";

  time.timeZone = "America/Sao_Paulo";

  environment.systemPackages = with pkgs; [
    mdadm
    megacmd
  ];

  boot.swraid = {
    enable = true;
    mdadmConf = lib.readFile ./mdadm.conf;
  };

  fileSystems."/mnt/storage" = {
    device = "/dev/md0";
    fsType = "ext4";
  };

  system.stateVersion = "24.11";
}
