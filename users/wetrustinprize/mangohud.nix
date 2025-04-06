{ pkgs, ... }: {
	home.packages = with pkgs; [
		mangohud
	];

	programs.mangohud = {
		enable = true;
		enableSessionWide = true;

		settings = {
			"toggle_hud" = "Shift_R+Enter";
		};
	};
}