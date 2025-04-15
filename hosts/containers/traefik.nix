{ ... }: {
    virtualisation.oci-containers.containers."traefik" = {
        image = "traefik:v3.3";
        autoStart = true;
        cmd = ["--api.insecure=true", "--providers.docker"];
        ports = [
            "80:80"
            "8080:8080"
        ];
    };
}