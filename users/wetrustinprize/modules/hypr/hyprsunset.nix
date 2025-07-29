{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    hyprsunset
  ];

  wayland.windowManager.hyprland.settings.exec-once = lib.mkAfter [ "hyprsunset" ];

  services.hyprsunset = {
    enable = true;
    transitions = {
      sunrise = {
        calendar = "*-*-* 06:00:00";
        requests = [
          [
            "identity"
            "true"
          ]
        ];
      };
      sunset = {
        calendar = "*-*-* 20:00:00";
        requests = [
          [
            "temperature"
            "5500"
          ]
          [
            "gamma"
            "0.8"
          ]
        ];
      };
    };
  };
}
