{ ... }: {
  virtualisation.oci-containers.containers."nextcloud" = {
    image = "nextcloud:latest";
    autoStart = true;
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.actual.rule" =
        "Host(`nextcloud.wetrustinprize.com`) || Host(`nextcloud.home.wetrustinprize.com`)";
      "traefik.http.routers.actual.tls" = "true";
      "traefik.http.routers.actual.tls.certresolver" = "cloudflare";
      "traefik.http.routers.actual.entrypoints" = "websecure";
      "traefik.http.services.actual.loadbalancer.server.port" = "80";
    };
  };
}
