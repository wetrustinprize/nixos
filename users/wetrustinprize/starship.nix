{config, ...}: {
	programs.starship = {
		enable = true;
		enableBashIntegration = true;
		enableNushellIntegration = true;

		settings = {
			palette = "nix-colors";
			palettes.nix-colors = {
				black = "#${config.colorScheme.palette.base00}";
				red = "#${config.colorScheme.palette.base08}";
				green = "#${config.colorScheme.palette.base0B}";
				blue = "#${config.colorScheme.palette.base0D}";
				yellow = "#${config.colorScheme.palette.base0A}";
				purple = "#${config.colorScheme.palette.base0E}";
				cyan = "#${config.colorScheme.palette.base0C}";
				white = "#${config.colorScheme.palette.base05}";
			};
		};
	};
}