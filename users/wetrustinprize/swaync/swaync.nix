{ config, lib, self, ... }: {
  services.swaync = {
    enable = true;

	style = self.lib.nixColorsReplace { scheme = config.colorScheme; text = (lib.readFile ./style.css); };
  };
}