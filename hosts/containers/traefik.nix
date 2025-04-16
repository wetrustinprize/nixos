{ ... }: {
    virtualisation.oci-containers.containers."traefik" = {
        image = "traefik:v3.3";
        autoStart = true;
        cmd = ["--api.insecure=true" "--providers.docker"];
        volumes = [
            "/var/run/docker.sock:/var/run/docker.sock"
        ];
        ports = [
            "80:80"
            "8080:8080"
        ];
    };
}
