{ ... }:
{
  virtualisation.oci-containers.containers."filebrowser" = {
    image = "filebrowser/filebrowser";
    autoStart = true;
    volumes = [
      "${builtins.toPath ./config.json}:/.filebrowser.json:ro"
      "/srv/filebrowser/database.db:/database.db:rw"
      "/mnt/storage:/srv:rw"
    ];
    labels = {
      # Traefik
      "traefik.enable" = "true";
      "traefik.http.routers.filebrowser.rule" = "Host(`filebrowser.home.wetrustinprize.com`)";
      "traefik.http.routers.filebrowser.entrypoints" = "web";
      "traefik.http.services.filebrowser.loadbalancer.server.port" = "80";

      # Homepage
      "homepage.group" = "Server";
      "homepage.name" = "File Browser";
      "homepage.icon" = "filebrowser.png";
      "homepage.description" = "Simple file browser.";
      "homepage.href" = "https://filebrowser.home.wetrustinprize.com";
    };
  };
}
