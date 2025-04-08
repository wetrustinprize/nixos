{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mangohud
  ];

  programs.mangohud = {
    enable = true;

    settings = {
      "toggle_hud" = "Shift_R+Enter";
    };
  };
}
