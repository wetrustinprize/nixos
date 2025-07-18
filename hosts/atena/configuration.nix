{
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ../common.nix
    ../docker.nix

    ./containers/cloudflared/cloudflared.nix
    ./containers/pihole/pihole.nix
    ./containers/traefik/traefik.nix
    ./containers/foundryvtt/foundryvtt.nix
    ./containers/filebrowser/filebrowser.nix
    ./containers/homepage/homepage.nix
    ./containers/actual.nix
    ./containers/qbittorrent.nix
    ./containers/postgres.nix
    ./containers/kimai.nix

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

  systemd.services.atena-network = {
    description = "Create Docker network for Atena containers";
    after = [ "docker.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      Environment = "PATH=/run/current-system/sw/bin";
    };
    script = ''
      docker network inspect atena >/dev/null 2>&1 || docker network create atena
    '';
  };

  system.stateVersion = "24.11";
}
