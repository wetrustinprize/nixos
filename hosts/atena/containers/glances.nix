{ ... }:
{
  virtualisation.oci-containers.containers."glances" = {
    image = "nicolargo/glances:latest";
    autoStart = true;
    environment = {
      "GLANCES_OPT" = "-w";
    };
    ports = [
      "61208:61208"
    ];
    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock"
      "/etc/os-release:/etc/os-release:ro"
    ];
    labels = {
      # Traefik
      "traefik.enable" = "true";
      "traefik.http.routers.glances.rule" = "Host(`glances.home.wetrustinprize.com`)";
      "traefik.http.routers.glances.entrypoints" = "web";
      "traefik.http.services.glances.loadbalancer.server.port" = "61208";

      # Homepage
      "homepage.group" = "Server";
      "homepage.name" = "Glances";
      "homepage.icon" = "glances.png";
      "homepage.description" = "Server monitoring.";
      "homepage.href" = "https://glances.home.wetrustinprize.com";
    };
  };
}
