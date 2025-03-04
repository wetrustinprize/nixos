{ pkgs, lib, self, config, ... }:
let
	modules = import ./modules.nix { inherit lib; };
in
{
  programs.waybar = {
    enable = true;
    style =  self.lib.nixColorsToGtkCss config.colorScheme + lib.readFile ./style.css;
    settings = {
		statusBar = lib.recursiveUpdate {
			layer = "top";
			position = "top";
			reload_style_on_change = true;
			output = [
				"HDMI-A-1"
			];
			modules-left = [
				"bluetooth"
				"cpu"
				"memory"
			];
			modules-center = [ "clock" ];
			modules-right = [
				"network"
			];
		} modules;
      mainBar = lib.recursiveUpdate {
        layer = "top";
        position = "top";
        reload_style_on_change = true;
        output = [
          "DP-1"
        ];
        modules-left = [
          "clock"
          "custom/pkgs"
        ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [ 
			"tray"
		  "pulseaudio"
          "custom/notification"
			];
      } modules;

    };
  };
}
