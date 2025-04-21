{ ... }:
{
  virtualisation.oci-containers.containers."filebrowser" = {
    image = "filebrowser/filebrowser";
    autoStart = true;
    volumes = [
      "${builtins.toPath ./config.json}:/.filebrowser.json:ro"
      "/mnt/storage:/srv:rw"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.filebrowser.rule" =
        "Host(`filebrowser.wetrustinprize.com`) || Host(`filebrowser.home.wetrustinprize.com`)";
      "traefik.http.routers.filebrowser.tls" = "true";
      "traefik.http.routers.filebrowser.tls.certresolver" = "cloudflare";
      "traefik.http.routers.filebrowser.entrypoints" = "websecure";
      "traefik.http.services.filebrowser.loadbalancer.server.port" = "80";
    };
  };
}
