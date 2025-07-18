{ ... }:
{
  virtualisation.oci-containers.containers."kimai" = {
    image = "kimai/kimai2:apache";
    autoStart = true;
    dependsOn = [ "postgres" ];
    labels = {
      # Traefik
      "traefik.enable" = "true";
      "traefik.http.routers.kimai.rule" =
        "Host(`kimai.wetrustinprize.com`) || Host(`kimai.home.wetrustinprize.com`)";
      "traefik.http.routers.kimai.tls" = "true";
      "traefik.http.routers.kimai.tls.certresolver" = "cloudflare";
      "traefik.http.routers.kimai.entrypoints" = "websecure";
      "traefik.http.services.kimai.loadbalancer.server.port" = "8001";

      # Homepage
      "homepage.group" = "Tools";
      "homepage.name" = "Kimai";
      "homepage.icon" = "kimai.png";
      "homepage.description" = "Time tracking.";
      "homepage.href" = "https://kimai.wetrustinprize.com";
    };
    volumes = [
      "/srv/kimai:/data"
    ];
  };
}
