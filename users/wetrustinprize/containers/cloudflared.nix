{ lib, config, ... }:

let
  hasSecret = lib.hasAttr "cloudflared" config.sops.secrets;
  token = builtins.readFile config.sops.secrets.cloudflared.path;
in
{
  config = {
    assertions = [
      {
        assertion = hasSecret;
        message = "Secret 'cloudflared' not found — skipping cloudflared container.";
      }
    ];

    services.podman.containers = lib.mkIf hasSecret {
      "cloudflared" = {
        image = "cloudflare/cloudflared:latest";
        autoStart = true;
        autoUpdate = "local";
        environment = {
          TUNNEL_TOKEN = token;
        };
      };
    };
  };
}