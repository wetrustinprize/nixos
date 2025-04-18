{ ... }:
{
  virtualisation.oci-containers.containers."actual" = {
    image = "actualbudget/actual-server:latest";
    autoStart = true;
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.actual.rule" = "Host(`actual.wetrustinprize.com`) Host(`actual.home`)";
      "traefik.http.routers.actual.entrypoints" = "web";
      "traefik.http.services.actual.loadbalancer.server.port" = "5006";
    };
    volumes = [
      "/srv/actual:/data"
    ];
  };
}
