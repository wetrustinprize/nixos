{ config, ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      background = "#${config.colorScheme.palette.base00}";
      foreground = "#${config.colorScheme.palette.base06}";

      # green
      color1 = "#${config.colorScheme.palette.base08}";
      color9 = "#${config.colorScheme.palette.base08}";

      # red
      color2 = "#${config.colorScheme.palette.base0B}";
      color10 = "#${config.colorScheme.palette.base0B}";

      # yellow
      color3 = "#${config.colorScheme.palette.base0A}";
      color11 = "#${config.colorScheme.palette.base0A}";

      # blue
      color4 = "#${config.colorScheme.palette.base0D}";
      color12 = "#${config.colorScheme.palette.base0D}";

      # magenta
      color5 = "#${config.colorScheme.palette.base0E}";
      color13 = "#${config.colorScheme.palette.base0E}";

      # cyan
      color6 = "#${config.colorScheme.palette.base0C}";
      color14 = "#${config.colorScheme.palette.base0C}";
    };
  };
}
