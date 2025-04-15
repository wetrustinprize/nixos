{
  lib,
  config,
  host,
  hostname,
  ...
}:
{
  sops.secrets.cloudflared = {
    format = "dotenv";
    sopsFile = ./.env.${hostname};
    restartUnits = [ "podman-cloudflared" ];
  };

  services.podman.containers = {
    "cloudflared" = {
      image = "docker.io/cloudflare/cloudflared:latest";
      autoStart = true;
      environmentFile = [
        config.sops.secrets.cloudflared.path
      ];
    };
  };
}
