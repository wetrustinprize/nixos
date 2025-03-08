{
  config,
  ...
}:
{
  services.hyprpaper = {
    enable = true;

    settings = {
      splash = true;
      splash_color = config.colorScheme.palette.base0C;
    };
  };
}
