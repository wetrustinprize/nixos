{ ... }:
{
  wayland.windowManager.hyprland = {
    settings = {
      exec-once = [
        "systemctl --user start hyprpolkitagent"
      ];
    };
  };

  services.hyprpolkitagent.enable = true;
}
