{...}: {
  flake.nixosModules.tailscale = {config, ...}: let
    hostname = config.networking.hostName;
  in {
    sops.secrets."tailscale-token" = {};

    services.tailscale = {
      enable = true;

      authKeyFile = config.sops.secrets."tailscale-token".path;

      authKeyParameters = {
        ephemeral = false;
        preauthorized = true;
      };

      extraUpFlags = ["--advertise-tags=tag:nixos"];
    };
  };
}
