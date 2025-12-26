{ pkgs, ... }: {
  # effects for the mic
  services.easyeffects = {
    enable = true;
    extraPresets = {
      "VocalClarity" = builtins.fromJSON( builtins.readFile( pkgs.fetchurl {
          url = "https://gist.githubusercontent.com/jtrv/47542c8be6345951802eebcf9dc7da31/raw/ead1e7f7bded4adc690cc2371a8fdd97ea08b4ef/EasyEffects%2520Microphone%2520Preset:%2520Masc%2520NPR%2520Voice%2520+%2520Noise%2520Reduction.json";
          sha256 = "sha256-taDkpQLEsenfIpQuKpcH8jvVUOcQ8bx50SJgCztdSvU=";
      }));
    };
  };
}
