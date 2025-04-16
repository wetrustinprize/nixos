{ ... }: {
    virtualisation.oci-containers.containers."actual" = {
        image = "actualbudget/actual-server:latest";
        autoStart = true;
        labels = {
            "traefik.http.routers.actual.rule" = "Path(`/actual`)";
        };
        ports = [
            "5006:5006"
        ];
        volumes = [
            "/srv/actual:/data"
        ];
    };
}