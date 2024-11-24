{ pkgs, lib, ... }:

{
  imports = [
    ../desktop.nix
  ];

  services.polybar.settings."bar/primary".modules-right = lib.mkForce
    "pulseaudio divider mute-mic mute-dunst divider battery divider open date time close";
  services.polybar.settings."module/battery" = {
    battery = "BAT1";
    adapter = "ADP1";
  };

  services.dunst.settings.global.font = lib.mkForce "Jetbrain 14";
  services.blueman-applet.enable = true;

  home.packages = with pkgs; [
    code-cursor
    godot_4
  ];
}
