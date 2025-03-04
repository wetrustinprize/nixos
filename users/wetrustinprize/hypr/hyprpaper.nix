{ pkgs, config, lib, ... }:
let
	mkWallpaper = { width, height }: pkgs.runCommand "generated-wallpaper-${config.colorScheme.slug}.png" { 
		nativeBuildInputs = with pkgs; [ imagemagick ];
		src = lib.fileset.toSource {
			root = ./.;
			fileset = ./logo.png;
		};
	}
	''
		magick -size ${toString width}x${toString height} xc:"#${config.colorScheme.palette.base00}" \
			${./logo.png} -gravity center -composite \
			$out
	'';
in
let
	mainWallpaper = mkWallpaper { width = 1920; height = 1080; };
	secondaryWallpaper = mkWallpaper { width = 1080; height = 1920; };
in
{
	services.hyprpaper = {
		enable = true;

		settings = {
			preload = [
				"${mainWallpaper}"
				"${secondaryWallpaper}"
			];
			wallpaper = [
				"DP-1, ${mainWallpaper}"
				"HDMI-A-1, ${secondaryWallpaper}"
			];
			splash = true;
			splash_color = config.colorScheme.palette.base0C;
		};
};
}