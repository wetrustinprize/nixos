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
  };

  virtualisation.oci-containers.containers."cloudflared" = {
    image = "docker.io/cloudflare/cloudflared:latest";
    autoStart = true;
    cmd = ["--token $TUNNEL_TOKEN"];
    environmentFiles = [
      config.sops.secrets.cloudflared.path
    ];
  };
}
