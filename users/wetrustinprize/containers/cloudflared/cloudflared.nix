{
  lib,
  config,
  host,
  hostname,
  ...
}:
{
  sops.secrets.cloudflared = {
    format = "env";
    sopsFile = ./env.${hostname};
  };
  services.podman.containers = {
    "cloudflared" = {
      image = "cloudflare/cloudflared:latest";
      autoStart = true;
      autoUpdate = "local";
      environmentFile = [
        config.sops.secrets.cloudflared.path
      ];
    };
  };
}
