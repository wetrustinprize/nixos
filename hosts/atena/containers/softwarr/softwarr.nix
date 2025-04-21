# Sadly, the wole arr softwares
# have a fucking shitty configuration
# system, so everytime this is freshly
# built it needs to be configured manually
# by using the ui. :\

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
    "overseerr" = {
      image = "lscr.io/linuxserver/overseerr:latest";
      autoStart = true;
      labels = {
        "traefik.enable" = "true";
        "traefik.http.routers.overseerr.rule" =
          "Host(`overseerr.wetrustinprize.com`) || Host(`overseerr.home.wetrustinprize.com`)";
        "traefik.http.routers.overseerr.tls" = "true";
        "traefik.http.routers.overseerr.tls.certresolver" = "cloudflare";
        "traefik.http.routers.overseerr.entrypoints" = "websecure";
        "traefik.http.services.overseerr.loadbalancer.server.port" = "5055";
      };
      extraOptions = [ "--network=softwarr-network" ];
    };
  };
}
