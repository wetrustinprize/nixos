{ lib, ... }:
let
  token = (lib.readFile ./cloudflared);
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
