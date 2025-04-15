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
    extraOptions = [ "--network=host" ];
    cmd = [
      "tunnel"
      "run"
    ];
    environmentFiles = [
      config.sops.secrets.cloudflared.path
    ];
  };
}
