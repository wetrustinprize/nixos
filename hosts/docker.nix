{ pkgs, lib, username, ... }:
{
  virtualisation.docker.enable = true;
  virtualisation.oci-containers.backend = "docker";

  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  users.users.${username}.extraGroups = lib.mkAfter ["docker"];
}
