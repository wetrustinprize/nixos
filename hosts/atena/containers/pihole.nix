{ ... }: {
    virtualisation.oci-containers.containers."pihole" = {
        image = "pihole/pihole:latest";
        ports = [
            # DNS Ports
            "53:53/tcp"
            "53:53/tcp"
        ];
        environment = {
            "TZ" = "America/Sao_Paulo";
            "FTLCONF_dns_listeningMode" = "all";

            # FIXME: Make this more secure
            "FTLCONF_webserver_api_password" = "pihole"; 
        };
        labels = {
            "label=traefik.enable" = "true";
            "label=traefik.http.routers.pihole.rule" = "Path(`/pihole`)";
            "label=traefik.http.routers.pihole.entrypoints" = "websecure";
            "label=traefik.http.routers.pihole.tls" = "true";
            "label=traefik.http.services.pihole.loadbalancer.server.port" = "80";
        };
        volumes = [
            "/srv/pihole:/etc/pihole"
        ];
    };
}