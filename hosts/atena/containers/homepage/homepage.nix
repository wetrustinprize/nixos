{ ... }:
{
  virtualisation.oci-containers.containers."homepage" = {
    image = "ghcr.io/gethomepage/homepage:latest";
    autoStart = true;
    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock"
      "${builtins.toPath ./bookmarks.yaml}:/app/config/bookmarks.yaml:ro"
      "${builtins.toPath ./docker.yaml}:/app/config/docker.yaml:ro"
      "${builtins.toPath ./services.yaml}:/app/config/services.yaml:ro"
      "${builtins.toPath ./settings.yaml}:/app/config/settings.yaml:ro"
      "${builtins.toPath ./widgets.yaml}:/app/config/widgets.yaml:ro"
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
