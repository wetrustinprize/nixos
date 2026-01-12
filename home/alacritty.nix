{ ... }: {
  programs.niri.settings.environment = {
    TERMINAL = "alacritty";
  };

  programs.alacritty = {
    enable = true;
  };
}
