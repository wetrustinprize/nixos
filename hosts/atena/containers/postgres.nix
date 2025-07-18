{ ... }:
{
  virtualisation.oci-containers.containers."postgres" = {
    image = "postgres:latest";
    autoStart = true;
    environment = {
      "POSTGRES_USER" = "wetrustinprize";
      "POSTGRES_PASSWORD" = "wetrustinprize";
    };
    ports = [
      "5432:5432"
    ];
  };
}
