{ lib, ... }:
let
  env = { };
in
{
  services.podman = {
    networks."karakeep" = { };
    volumes = {
      "karakeep" = { };
      "meilisearch" = { };
    };

    containers = {
      "karakeep" = {
        image = "ghcr.io/karakeep-app/karakeep:release";
        autoStart = true;
        ports = [ "3000:3000" ];
        volumes = [ "karakeep:/data" ];
        environment = lib.recursiveUpdate env {
          MEILI_HOST = "http://meilisearch:7700";
          BROWSER_WEB_URL = "http://chrome:9222";
          DATA_DIR = "/data";
        };
      };
      "chrome" = {
        image = "gcr.io/zenika-hub/alpine-chrome:123";
        autoStart = true;
        exec = [
          "--no-sandbox"
          "--disable-dev-shm-usage"
          "--disable-gpu"
          "--remote-debugging-port=9222"
          "--remote-debugging-address=0.0.0.0"
          "--hide-scrollbars"
        ];
      };
      "meilisearch" = {
        image = "getmeili/meilisearch:v1.11.1";
        autoStart = true;
        environment = lib.recursiveUpdate env {
          MEILI_NO_ANALYTICS = "true";
        };
        volumes = [ "meilisearch:/data" ];
      };
    };
  };
}
