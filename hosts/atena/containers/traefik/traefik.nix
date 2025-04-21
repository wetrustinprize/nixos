{ config, ... }:
{
  sops.secrets.traefik = {
    format = "dotenv";
    sopsFile = ./.env;
  };

  virtualisation.oci-containers.containers."traefik" = {
    image = "traefik:v3.3";
    autoStart = true;
    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock"
      "/srv/traefik/certs/:/etc/traefik/certs/:rw"
      "${builtins.toPath ./traefik.yaml}:/etc/traefik/traefik.yaml:ro"
    ];
    ports = [
      "80:80"
      "443:443"
    ];
    labels = {
      # Traefik
      "traefik.enable" = "true";
      "traefik.http.routers.traefik.rule" = "Host(`traefik.home.wetrustinprize.com`)";
      "traefik.http.routers.traefik.entrypoints" = "web";
      "traefik.http.services.traefik.loadbalancer.server.port" = "8080";

      # Homepage
      "homepage.group" = "Server";
      "homepage.name" = "Traefik";
      "homepage.description" = "Reverse-proxy manager.";
      "homepage.href" = "https://traefik.home.wetrustinprize.com";
    };
    environmentFiles = [
      config.sops.secrets.traefik.path
    ];
  };
}
