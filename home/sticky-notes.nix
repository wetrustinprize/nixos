{ pkgs, ... }:
{
  home.packages = with pkgs; [
    sticky-notes
  ];

  # wayland.windowManager.hyprland.settings = {
  #   bind = [
  #     "$mod, N, exec, com.vixalien.sticky -n"
  #     "$mod SHIFT, N, exec, com.vixalien.sticky -a"
  #   ];
  #   windowrulev2 = [
  #     "float,class:(com.vixalien.sticky)"
  #   ];
  # };
}
