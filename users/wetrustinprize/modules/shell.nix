{ config, ... }:
{
  home.shell = {
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  programs.yazi = {
    enable = true;
  };

  programs.fish = {
    enable = true;
    shellInit = ''
      if command -q nix-your-shell
          nix-your-shell fish | source
      end
    '';
  };
  programs.bash.enable = true;

  programs.zoxide.enable = true;
  programs.fzf.enable = true;

  programs.starship = {
    enable = true;

    settings = {
      palette = "nix-colors";
      palettes.nix-colors = {
        black = "#${config.colorScheme.palette.base00}";
        red = "#${config.colorScheme.palette.base08}";
        green = "#${config.colorScheme.palette.base0B}";
        blue = "#${config.colorScheme.palette.base0D}";
        yellow = "#${config.colorScheme.palette.base0A}";
        purple = "#${config.colorScheme.palette.base0E}";
        cyan = "#${config.colorScheme.palette.base0C}";
        white = "#${config.colorScheme.palette.base06}";
        bright-white = "#${config.colorScheme.palette.base07}";
      };
    };
  };
}
