{ ... }:
{
  virtualisation.oci-containers.containers = {
    "matrix-synapse" = {
      image = "matrixdotorg/synapse:latest";
      autoStart = true;
      cmd = [ "generate" ];
    };
  };
}
