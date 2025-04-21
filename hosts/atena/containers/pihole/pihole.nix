{ ... }:
{
  virtualisation.oci-containers.containers."pihole" = {
    image = "pihole/pihole:latest";
    autoStart = true;
    ports = [
      "53:53/tcp"
      "53:53/udp"
    ];
    environment = {
      "TZ" = "America/Sao_Paulo";
      "FTLCONF_dns_listeningMode" = "all";

      # FIXME: Make this more secure
      "FTLCONF_webserver_api_password" = "pihole";
    };
    labels = {
      # Traefik
      "traefik.enable" = "true";
      "traefik.http.routers.pihole.rule" = "Host(`pihole.home.wetrustinprize.com`)";
      "traefik.http.routers.pihole.entrypoints" = "web";
      "traefik.http.services.pihole.loadbalancer.server.port" = "80";

      # Homepage
      "homepage.name" = "piHole";
      "homepage.description" = "Custom DNS.";
      "homepage.href" = "https://pihole.home.wetrustinprize.com";
    };
    volumes = [
      "${builtins.toPath ./pihole.toml}:/etc/pihole/pihole.toml:ro"
    ];
  };
}
