{ inputs, pkgs, ... }:
{
  services.ollama = {
    enable = true;
    loadModels = [
      "deepseek-r1:7b"
      "llava:7b"
    ];
  };
}
