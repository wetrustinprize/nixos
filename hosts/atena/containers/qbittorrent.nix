{ ... }:
{
  virtualisation.oci-containers.containers."qbittorrent" = {
    image = "lscr.io/linuxserver/qbittorrent:latest";
    autoStart = true;
    volumes = [
      "/srv/qbittorrent:/config:rw"
      "/mnt/storage/torrent:/downloads:rw"
    ];
    environment = {
      "PUID" = "1000";
      "PGID" = "1000";
    };
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.qbittorrent.rule" = "Host(`qbittorrent.home.wetrustinprize.com`)";
      "traefik.http.routers.qbittorrent.entrypoints" = "web";
      "traefik.http.services.qbittorrent.loadbalancer.server.port" = "8080";
    };
  };
}
