{config, ...}: {
	programs.starship = {
		enalbe = true;
		enableBashIntegration = true;
		enableNushellIntegration = true;

		settings = {
			pallete = "nix-colors";
			palletes.nix-colors = {
				black = "#${config.colorScheme.base00}";
				red = "#${config.colorScheme.base08}";
				green = "#${config.colorScheme.base0B}";
				blue = "#${config.colorScheme.base0D}";
				yellow = "#${config.colorScheme.base0A}";
				purple = "#${config.colorScheme.base0E}";
				cyan = "#${config.colorScheme.base0C}";
				white = "#${config.colorScheme.base05}";
			};
		};
	};
}