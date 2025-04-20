{ ... }: {
  virtualisation.oci-containers.containers."nextcloud" = {
    image = "nextcloud:latest";
    autoStart = true;
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.nextcloud.rule" =
        "Host(`nextcloud.wetrustinprize.com`) || Host(`nextcloud.home.wetrustinprize.com`)";
      "traefik.http.routers.nextcloud.tls" = "true";
      "traefik.http.routers.nextcloud.tls.certresolver" = "cloudflare";
      "traefik.http.routers.nextcloud.entrypoints" = "websecure";
      "traefik.http.services.nextcloud.loadbalancer.server.port" = "80";
    };
  };
}
