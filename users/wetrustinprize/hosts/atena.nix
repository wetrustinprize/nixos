{ pkgs, ...}: {
	home.packages = with pkgs; [
		megacmd
	];
}