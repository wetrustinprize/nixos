{ lib, config, ... }:
let
  hasSecret = lib.hasAttr "cloudflared" config.sops.secrets;
  token = lib.readFile config.sops.secrets.cloudflared.path;
in
{
  config = lib.mkIf hasSecret {
    services.podman.containers."cloudflared" = {
      image = "cloudflare/cloudflared:latest";
      autoStart = true;
      autoUpdate = "local";
      environment = {
        TUNNEL_TOKEN = token;
      };
    };
  };

  assertions = [
    {
      assertion = hasSecret;
      message = "Secret 'cloudflared' not found — skipping cloudflared container.";
    }
  ];
}