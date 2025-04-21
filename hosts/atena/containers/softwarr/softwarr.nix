{ ... }:
let
    genTraefikLabels = { service, port }: {
      "traefik.enable" = "true";
      "traefik.http.routers.${service}.rule" =
        "Host(`softwarr.home.wetrustinprize.com`) & PathPrefix(`${service}`)";
      "traefik.http.routers.${service}.entrypoints" = "web";
      "traefik.http.routers.${service}.middlewares" = "strip-${service}";
      "traefik.http.middlewares.${service}.stripprefix.prefixes" = "/${service}";
      "traefik.http.services.${service}.loadbalancer.server.port" = "${port}";
    };
in
{
    virtualisation.oci-containers.containers = {
        "prowlarr" = {
            image = "lscr.io/linuxserver/prowlarr:latest";
            autoStart = true;
            labels = genTraefikLabels { service="prowlarr"; port=9696; };
        };
    };
}
