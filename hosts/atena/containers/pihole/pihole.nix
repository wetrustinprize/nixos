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
      "traefik.enable" = "true";
      "traefik.http.routers.pihole.rule" = "Host(`pihole.home.wetrustinprize.com`)";
      "traefik.http.routers.pihole.entrypoints" = "web";
      "traefik.http.services.pihole.loadbalancer.server.port" = "80";
    };
    volumes = [
      "${builtins.toPath ./pihole.toml}:/etc/pihole/pihole.toml:ro"
    ];
  };
}
