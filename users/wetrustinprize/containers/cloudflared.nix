{ lib, config, ... }:

let
  hasSecret = lib.hasAttr "cloudflared" config.sops.secrets;
  _ = lib.warnIf (!hasSecret) "⚠️ Secret 'cloudflared' not found — skipping cloudflared container.";

  token = builtins.readFile config.sops.secrets.cloudflared.path;
in
{
  config = {
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