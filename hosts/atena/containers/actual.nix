{ ... }: {
    virtualisation.oci-containers.containers."actual" = {
        image = "actualbudget/actual-server:latest";
        autoStart = true;
        labels = {
            "traefik.enable" = "true";
            "traefik.http.routers.actual.rule" = "Path(`/actual`)";
            "traefik.http.routers.actual.entrypoints" = "http";
            "traefik.http.routers.actual.middlewares" = "actual-strip";
            "traefik.http.middlewares.actual-strip.stripprefix.prefixes" = "/actual";
            "traefik.http.services.actual.loadbalancer.server.port" = "5006";
        };
        volumes = [
            "/srv/actual:/data"
        ];
    };
}