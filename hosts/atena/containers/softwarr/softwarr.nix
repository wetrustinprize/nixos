# Sadly, the wole arr softwares
# have a fucking shitty configuration
# system, so everytime this is freshly
# built it needs to be configured manually
# by using the ui. :\

# TODO: Make the configuration be made with the flemmarr
# https://github.com/Flemmarr/Flemmarr

{ ... }:
let
  genTraefikLabels =
    { service, port }:
    {
      "traefik.enable" = "true";
      "traefik.http.routers.${service}.rule" =
        "Host(`softwarr.home.wetrustinprize.com`) && PathPrefix(`/${service}`)";
      "traefik.http.routers.${service}.entrypoints" = "web";
      "traefik.http.services.${service}.loadbalancer.server.port" = "${toString port}";
    };
in
{
  systemd.services.softwarr-network = {
    description = "Create Docker network for softwarr services";
    after = [ "docker.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      Environment = "PATH=/run/current-system/sw/bin";
    };
    script = ''
      docker network inspect softwarr-network >/dev/null 2>&1 || docker network create softwarr-network
    '';
  };

  virtualisation.oci-containers.containers = {
    "softwarr-torrent" = {
      imnage = "lscr.io/linuxserver/qbittorrent:latest";
      autoStart = true;
    };
    "prowlarr" = {
      image = "lscr.io/linuxserver/prowlarr:latest";
      autoStart = true;
      volumes = [ "/srv/prowlarr:/config:rw" ];
      labels = genTraefikLabels {
        service = "prowlarr";
        port = 9696;
      };
      extraOptions = [ "--network=softwarr-network" ];
    };
    "radarr" = {
      image = "lscr.io/linuxserver/radarr:latest";
      autoStart = true;
      volumes = [
        "/srv/radarr:/config:rw"
        "/mnt/storage/movies:/movies:rw"
      ];
      environment = {
        "PUID" = "1000";
        "PGID" = "1000";
      };
      labels = genTraefikLabels {
        service = "radarr";
        port = 7878;
      };
      extraOptions = [ "--network=softwarr-network" ];
    };
    "sonarr" = {
      image = "lscr.io/linuxserver/sonarr:latest";
      autoStart = true;
      volumes = [
        "/srv/sonarr:/config:rw"
        "/mnt/storage/tv:/tv"
      ];
      environment = {
        "PUID" = "1000";
        "PGID" = "1000";
      };
      labels = genTraefikLabels {
        service = "sonarr";
        port = 8989;
      };
      extraOptions = [ "--network=softwarr-network" ];
    };
    "flaresolverr" = {
      image = "ghcr.io/flaresolverr/flaresolverr:latest";
      autoStart = true;
      extraOptions = [ "--network=softwarr-network" ];
    };
  };
}
