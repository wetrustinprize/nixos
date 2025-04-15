{ lib, config, ... }:
let
 token = lib.readFile config.sops.secrets.cloudflared.path;
in
{
  services.podman.containers = {
    "cloudflared" = {
      image = "cloudflare/cloudflared:latest";
      autoStart = true;
      autoUpdate = "local";
      environment = {
        TUNNEL_TOKEN = token;
      };
    };
  };
}
