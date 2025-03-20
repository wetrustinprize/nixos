{ inputs, pkgs, ... }:
{
  services.ollama = {
    enable = true;
    loadModels = [ "deepseek-r1:7b" "MFDoom/deepseek-r1-tool-calling:7b" ];
  };

  environment.systemPackages = with pkgs; [
    inputs.question.packages.${pkgs.system}.default
  ];
}
