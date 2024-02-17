{ config, ... }: {
  home.file.".config/rofi/themes" = {
    source = ./themes;
    recursive = true;
  };

  programs.rofi = {
    enable = true;
    theme = "./themes/rofi";
  };
}
