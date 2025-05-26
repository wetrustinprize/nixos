{ ... }:
{
    sops.secrets.foundryvtt = {
        format = "dotenv";
        sopsFile = ./.env;
    };

    virtualisation.oci-containers.containers."foundryvtt" = {
        image = "felddy/foundryvtt:latest";
        autoStart = true;
        labels = {
            # Traefik
            "traefik.enable" = "true";
            "traefik.http.routers.foundryvtt.rule" =
                "Host(`foundryvtt.wetrustinprize.com`) || Host(`foundryvtt.home.wetrustinprize.com`)";
            "traefik.http.routers.foundryvtt.tls" = "true";
            "traefik.http.routers.foundryvtt.tls.certresolver" = "cloudflare";
            "traefik.http.routers.foundryvtt.entrypoints" = "websecure";
            "traefik.http.services.foundryvtt.loadbalancer.server.port" = "30000";

            # Homepage
            "homepage.group" = "Tools";
            "homepage.name" = "foundryvtt";
            "homepage.icon" = "foundryvtt-budget.png";
            "homepage.description" = "Finacnes organizer.";
            "homepage.href" = "https://foundryvtt.wetrustinprize.com";
        };
        volumes = [
            "/mnt/storage/foundryvtt:/data"
        ];
        environmentFiles = [
            config.sops.secrets.foundryvtt.path
        ];
    };
}