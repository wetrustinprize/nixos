{ ... }:
{
  virtualisation.oci-containers.containers."homepage" = {
    image = "ghcr.io/gethomepage/homepage:latest";
    autoStart = true;
    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock"
      "/srv/homepage:/app/config:rw"
    ];
    environment = {
      "HOMEPAGE_ALLOWED_HOSTS" = "home.wetrustinprize.com";
    };
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.homepage.rule" = "Host(`home.wetrustinprize.com`)";
      "traefik.http.routers.homepage.entrypoints" = "web";
      "traefik.http.services.homepage.loadbalancer.server.port" = "3000";
    };
  };
}
