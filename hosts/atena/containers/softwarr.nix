# Sadly, the wole arr softwares
# have a fucking shitty configuration
# system, so everytime this is freshly
# built it needs to be configured manually
# by using the ui. :\

# TODO: Make the configuration be made with the flemmarr
# https://github.com/Flemmarr/Flemmarr

{ lib, ... }:
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
  genHomepageLabels =
    { service, description }:
    {
      "homepage.group" = "Media";
      "homepage.name" = service;
      "homepage.icon" = "${service}.png";
      "homepage.description" = description;
      "homepage.href" = "https://softwarr.home.wetrustinprize.com/${service}";
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
    "jellyfin" = {
      image = "lscr.io/linuxserver/jellyfin:latest";
      autoStart = true;
      volumes = [
        "/srv/jellyfin:/config:rw"
        "/mnt/storage/movies:/movies:rw"
        "/mnt/storage/tv:/tvshows:rw"
      ];
      ports = [
        "7359:7359/udp"
      ];
      environment = {
        "PUID" = "1000";
        "PGID" = "1000";
      };
      labels = {
        # Traefik
        "traefik.enable" = "true";
        "traefik.http.routers.jellyfin.rule" =
          "Host(`jellyfin.wetrustinprize.com`) || Host(`jellyfin.home.wetrustinprize.com`)";
        "traefik.http.routers.jellyfin.tls" = "true";
        "traefik.http.routers.jellyfin.tls.certresolver" = "cloudflare";
        "traefik.http.routers.jellyfin.entrypoints" = "websecure";
        "traefik.http.services.jellyfin.loadbalancer.server.port" = "8096";

        # Homepage
        "homepage.group" = "Media";
        "homepage.name" = "Jellyfin";
        "homepage.icon" = "jellyfin.png";
        "homepage.description" = "Media server";
        "homepage.href" = "https://jellyfin.home.wetrustinprize.com";
      };
      extraOptions = [ "--network=softwarr-network" ];
    };
    "jellyseerr" = {
      image = "ghcr.io/fallenbagel/jellyseerr";
      autoStart = true;
      volumes = [ "/srv/jellyseer:/app/config:rw" ];
      labels = {
        # Traefik
        "traefik.enable" = "true";
        "traefik.http.routers.jellyseer.rule" =
          "Host(`jellyseer.wetrustinprize.com`) || Host(`jellyseer.home.wetrustinprize.com`)";
        "traefik.http.routers.jellyseer.tls" = "true";
        "traefik.http.routers.jellyseer.tls.certresolver" = "cloudflare";
        "traefik.http.routers.jellyseer.entrypoints" = "websecure";
        "traefik.http.services.jellyseer.loadbalancer.server.port" = "5055";

        # Homepage
        "homepage.group" = "Media";
        "homepage.name" = "Jellyseerr";
        "homepage.icon" = "jellyseerr.png";
        "homepage.description" = "Media requester";
        "homepage.href" = "https://jellyseer.home.wetrustinprize.com";
      };
      extraOptions = [ "--network=softwarr-network" ];
    };
    "tdarr" = {
      image = "ghcr.io/haveagitgat/tdarr:latest";
      autoStart = true;
      volumes = [
        "/srv/tdarr:/app/configs:rw"
        "/mnt/storage/movies:/media/movies:rw"
        "/mnt/storage/tv:/media/tv:rw"
      ];
      environment = {
        "PUID" = "1000";
        "PGID" = "1000";
        "BASE" = "/tdarr";
        "internalNode" = "true";
        "inContainer" = "true";
        "nodeName" = "internal";
      };
      labels =
        lib.recursiveUpdate
          (genHomepageLabels {
            service = "tdarr";
            description = "Softwarr transcoder.";
          })
          (genTraefikLabels {
            service = "tdarr";
            port = 8265;
          });
      extraOptions = [ "--network=softwarr-network" ];
    };
    "prowlarr" = {
      image = "lscr.io/linuxserver/prowlarr:latest";
      autoStart = true;
      volumes = [ "/srv/prowlarr:/config:rw" ];
      labels =
        lib.recursiveUpdate
          (genHomepageLabels {
            service = "prowlarr";
            description = "Softwarr indexer";
          })
          (genTraefikLabels {
            service = "prowlarr";
            port = 9696;
          });
      extraOptions = [ "--network=softwarr-network" ];
    };
    "bazarr" = {
      image = "lscr.io/linuxserver/bazarr:latest";
      autoStart = true;
      volumes = [
        "/srv/bazarr:/config:rw"
        "/mnt/storage/movies:/movies"
        "/mnt/storage/tv:/tv"
      ];
      environment = {
        "PUID" = "1000";
        "PGID" = "1000";
      };
      labels =
        lib.recursiveUpdate
          (genHomepageLabels {
            service = "bazarr";
            description = "Softwarr captions downloader.";
          })
          (genTraefikLabels {
            service = "bazarr";
            port = 6767;
          });
      extraOptions = [ "--network=softwarr-network" ];
    };
    "radarr" = {
      image = "lscr.io/linuxserver/radarr:latest";
      autoStart = true;
      volumes = [
        "/srv/radarr:/config:rw"
        "/mnt/storage/movies:/movies:rw"
        "/mnt/storage/torrent:/downloads:rw"
      ];
      environment = {
        "PUID" = "1000";
        "PGID" = "1000";
      };
      labels =
        lib.recursiveUpdate
          (genHomepageLabels {
            service = "radarr";
            description = "Movie fetcher";
          })
          (genTraefikLabels {
            service = "radarr";
            port = 7878;
          });
      extraOptions = [ "--network=softwarr-network" ];
    };
    "sonarr" = {
      image = "lscr.io/linuxserver/sonarr:latest";
      autoStart = true;
      volumes = [
        "/srv/sonarr:/config:rw"
        "/mnt/storage/tv:/tv"
        "/mnt/storage/torrent:/downloads:rw"
      ];
      environment = {
        "PUID" = "1000";
        "PGID" = "1000";
      };
      labels =
        lib.recursiveUpdate
          (genHomepageLabels {
            service = "sonarr";
            description = "TV Shows Fetcher";
          })
          (genTraefikLabels {
            service = "sonarr";
            port = 8989;
          });
      extraOptions = [ "--network=softwarr-network" ];
    };
    "flaresolverr" = {
      image = "ghcr.io/flaresolverr/flaresolverr:latest";
      autoStart = true;
      extraOptions = [ "--network=softwarr-network" ];
    };
  };
}
