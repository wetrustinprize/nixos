{ ... }: {
    virtualisation.oci-containers.containers."pihole" = {
        image = "pihole/pihole:latest";
        autoStart = true;
        ports = [
            # DNS Ports
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
            "label=traefik.enable" = "true";
            "label=traefik.http.routers.pihole.rule" = "Host(`pihole.wetrustinprize.com`)";
            "label=traefik.http.routers.pihole.entrypoints" = "web";
            "label=traefik.http.services.pihole.loadbalancer.server.port" = "80";
        };
        volumes = [
            "/srv/pihole:/etc/pihole"
            "./hosts.list:/etc/pihole/hosts/custom.list:ro"
        ];
    };
}