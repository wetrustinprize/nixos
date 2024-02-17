{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [ barrier ];

  xsession.windowManager.i3 = {
    config = {
      startup = [{
        command = "polybar --reload primary";
        notification = false;
      }];
    };
  };

  services.polybar.settings."bar/primary".modules-right = lib.mkForce
    "pulseaudio divider mute-mic mute-dunst divider battery divider open date time close";

  services.dunst.settings.global.font = lib.mkForce "Jetbrain 14";
}
