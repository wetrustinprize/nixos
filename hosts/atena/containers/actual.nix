{ ... }:
{
  virtualisation.oci-containers.containers."actual" = {
    image = "actualbudget/actual-server:latest";
    autoStart = true;
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.actual.rule" =
        "Host(`actual.wetrustinprize.com`) || Host(`actual.home.wetrustinprize.com`)";
      "traefik.http.routers.actual.tls" = "true";
      "traefik.http.routers.actual.tls.certresolver" = "cloudflare";
      "traefik.http.routers.actual.entrypoints" = "websecure";
      "traefik.http.services.actual.loadbalancer.server.port" = "5006";
    };
    volumes = [
      "/srv/actual:/data"
    ];
  };
}
