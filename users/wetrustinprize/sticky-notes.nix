{ pkgs, ... }:
{
  home.packages = with pkgs; [
    sticky-notes
  ];

  wayland.windowManager.hyprland.settings = {
    # exec-once = [
    #   "com.vixalien.sticky -i"
    # ];
    bind = [
      "$mod, N, exec, com.vixalien.sticky -n"
    ];
    # not avaliable yet in 0.45.2
    # bindo = [
    # 	"$mod, N, exec, com.vixalien.sticky"
    # ];
    windowrulev2 = [
      "float,class:(com.vixalien.sticky)"
    ];
  };
}
