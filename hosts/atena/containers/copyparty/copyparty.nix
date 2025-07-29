{ ... }:
{
  virtualisation.oci-containers.containers."copyparty" = {
    image = "copyparty/ac";
    autoStart = true;
    volumes = [
      "${builtins.toPath ./configs}:/cfg:ro"
      "/mnt/storage:/w:rw"
    ];
    labels = {
      # Traefik
      "traefik.enable" = "true";
      "traefik.http.routers.copyparty.rule" = "Host(`copyparty.home.wetrustinprize.com`)";
      "traefik.http.routers.copyparty.entrypoints" = "web";
      "traefik.http.services.copyparty.loadbalancer.server.port" = "3923";

      # Homepage
      "homepage.group" = "Server";
      "homepage.name" = "Copy Party";
      "homepage.icon" = "filebrowser.png";
      "homepage.description" = "Simple file browser.";
      "homepage.href" = "https://copyparty.home.wetrustinprize.com";
    };
    environment = {
      "TZ" = "America/Sao_Paulo";
      "PUID" = "1000";
      "PGID" = "1000";
    };
  };
}
