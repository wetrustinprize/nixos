{ ... }:
{
  virtualisation.oci-containers.containers."traefik" = {
    image = "traefik:v3.3";
    autoStart = true;
    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock"
      "${builtins.toPath ./traefik.yaml}:/etc/traefik/traefik.yaml:ro"
    ];
    ports = [
      "80:80"
      "443:443"
      "8080:8080"
    ];
  };
}
