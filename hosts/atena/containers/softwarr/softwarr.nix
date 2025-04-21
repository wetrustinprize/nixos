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
  virtualisation.oci-containers.containers = {
    "prowlarr" = {
      image = "lscr.io/linuxserver/prowlarr:latest";
      autoStart = true;
      volumes = ["${builtins.toPath ./prowlarr.xml}:/config/config.xml:ro"];
      labels = genTraefikLabels {
        service = "prowlarr";
        port = 9696;
      };
    };
    "radarr" = {
      image = "lscr.io/linuxserver/radarr:latest";
      autoStart = true;
      volumes = ["${builtins.toPath ./radarr.xml}:/config/config.xml:ro"];
      labels = genTraefikLabels {
        service = "radarr";
        port = 7878;
      };
    };
    "sonarr" = {
      image = "lscr.io/linuxserver/sonarr:latest";
      autoStart = true;
      volumes = ["${builtins.toPath ./sonarr.xml}:/config/config.xml:ro"];
      labels = genTraefikLabels {
        service = "sonnar";
        port = 8989;
      };
    };
    "flaresolverr" = {
      image = "ghcr.io/flaresolverr/flaresolverr:latest";
      autoStart = true;
      hostname = "flaresolverr";
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
        "traefik.http.services.overseerr.loadbalancer.server.port" = "5006";
      };
    };
  };
}
