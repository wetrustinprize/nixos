{ config, ... }:
{
  sops.secrets.foundryvtt = {
    format = "dotenv";
    sopsFile = ./.env;
  };

  virtualisation.oci-containers.containers."foundryvtt" = {
    image = "felddy/foundryvtt:latest";
    autoStart = true;
    labels = {
      # Traefik
      "traefik.enable" = "true";
      "traefik.http.routers.foundryvtt.rule" =
        "Host(`foundryvtt.wetrustinprize.com`) || Host(`foundryvtt.home.wetrustinprize.com`)";
      "traefik.http.routers.foundryvtt.tls" = "true";
      "traefik.http.routers.foundryvtt.tls.certresolver" = "cloudflare";
      "traefik.http.routers.foundryvtt.entrypoints" = "websecure";
      "traefik.http.services.foundryvtt.loadbalancer.server.port" = "30000";

      # Homepage
      "homepage.group" = "Tools";
      "homepage.name" = "foundryvtt";
      "homepage.icon" = "foundry-virtual-tabletop.png";
      "homepage.description" = "Virtual tabletop.";
      "homepage.href" = "https://foundryvtt.wetrustinprize.com";
    };
    volumes = [
      "/mnt/storage/foundryvtt:/data:rw"
    ];
    environment = {
      "TZ" = "America/Sao_Paulo";
      "PUID" = "1000";
      "PGID" = "1000";
    };
    environmentFiles = [
      config.sops.secrets.foundryvtt.path
    ];
    extraOptions = [
      "--dns=1.1.1.1"
    ];
  };
}
