{ pkgs, nixpkgs, usernames, ... }: {
  nixpkgs.config.allowUnfree = true;
  networking.networkmanager.enable = true;

  programs.git.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    lm_sensors
    neofetch
    killall
    tldr
  ];

  boot.plymouth = {
    enable = true;
    theme = "nixos-bgrt";
    themePackages = [ pkgs.nixos-bgrt-plymouth ];
  };

  nix.settings.trusted-users = [ "root" "@wheel" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.openssh = {
	enable = true;
	ports = [ 22 ];
	openFirewall = true;
	hostKeys = builtins.map (user: {
		type = "ed25519";
		path = "/etc/ssh/ssh_${user}_ed25519_key";
	}) usernames;
  };

  system.stateVersion = "24.05";
}
