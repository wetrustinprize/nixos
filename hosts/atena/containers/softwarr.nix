# Sadly, the wole arr softwares
# have a fucking shitty configuration
# system, so everytime this is freshly
# built it needs to be configured manually
# by using the ui. :\

# TODO: Make the configuration be made with the flemmarr
# https://github.com/Flemmarr/Flemmarr

{ lib, ... }:
let
  genLabels =
    {
      service,
      port,
      description,
    }:
    {
      # Traefik labels
      "traefik.enable" = "true";
      "traefik.http.routers.${service}.rule" =
        "Host(`softwarr.home.wetrustinprize.com`) && PathPrefix(`/${service}`)";
      "traefik.http.routers.${service}.entrypoints" = "web";
      "traefik.http.services.${service}.loadbalancer.server.port" = "${toString port}";

      # Homepage labels
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
        "TZ" = "America/Sao_Paulo";
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
      environment = {
        "TZ" = "America/Sao_Paulo";
      };
      labels = {
        # Traefik
        "traefik.enable" = "true";
        "traefik.http.routers.jellyseer.rule" =
          "Host(`jellyseerr.wetrustinprize.com`) || Host(`jellyseerr.home.wetrustinprize.com`)";
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
        "/srv/tdarr/config:/app/configs:rw"
        "/srv/tdarr/server:/app/server:rw"
        "/srv/tdarr/logs:/app/logs:rw"
        "/tmp/tdarr:/tmp/tdarr:rw"
        "/mnt/storage/movies:/media/movies:rw"
        "/mnt/storage/tv:/media/tv:rw"
      ];
      ports = [
        "8265:8265"
      ];
      environment = {
        "TZ" = "America/Sao_Paulo";
        "PUID" = "1000";
        "PGID" = "1000";
        "ROOT_URL" = "http://softwarr.home.wetrustinprize.com/tdarr";
        "BASE" = "/tdarr";
        "internalNode" = "true";
        "inContainer" = "true";
        "nodeName" = "internal";
      };
      labels =
        lib.recursiveUpdate
          (genLabels {
            service = "tdarr";
            description = "Softwarr transcoder.";
            port = 8265;
          })
          ({
            "traefik.http.routers.tdarr.middlewares" = "tdarr-strip,tdarr-pathregex";
            "traefik.http.middlewares.tdarr-strip.stripprefix.prefixes" = "/tdarr";
            "traefik.http.middlewares.tdarr-pathregex.replacepathregex.regex" = "^/tdarr(.*)";
            "traefik.http.middlewares.tdarr-pathregex.replacepathregex.replacement" = "$$1";
          });
      extraOptions = [ "--network=softwarr-network" ];
    };
    "prowlarr" = {
      image = "lscr.io/linuxserver/prowlarr:latest";
      autoStart = true;
      volumes = [ "/srv/prowlarr:/config:rw" ];
      labels = genLabels {
        service = "prowlarr";
        description = "Softwarr indexer";
        port = 9696;
      };
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
        "TZ" = "America/Sao_Paulo";
        "PUID" = "1000";
        "PGID" = "1000";
      };
      labels = genLabels {
        service = "bazarr";
        description = "Softwarr captions downloader.";
        port = 6767;
      };
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
        "TZ" = "America/Sao_Paulo";
        "PUID" = "1000";
        "PGID" = "1000";
      };
      labels = genLabels {
        service = "radarr";
        description = "Movie fetcher";
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
        "/mnt/storage/torrent:/downloads:rw"
      ];
      environment = {
        "TZ" = "America/Sao_Paulo";
        "PUID" = "1000";
        "PGID" = "1000";
      };
      labels = genLabels {
        service = "sonarr";
        description = "TV Shows Fetcher";
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
