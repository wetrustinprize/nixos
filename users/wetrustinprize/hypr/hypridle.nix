{ ... }:
{
  wayland.windowManager.hyprland = {
    exec-once = [
      "hypridle"
    ];
  };

  services.hypridle = {
    enable = true;
    settings = {
      listener = [
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
