{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [ unityhub gimp barrier ];

  xsession.windowManager.i3 = {
    config = {
      startup = [{
        command = "polybar --reload primary";
        notification = false;
      }];
    };
  };

  services.dunst.settings.global.font = lib.mkForce "Jetbrain 14";
}
