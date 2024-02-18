{ pkgs, ... }: {
  users.users.wetrustinprize = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  virtualisation.docker.enable = true;

  networking.networkmanager.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  nix.settings.trusted-users = [ "root" "@wheel" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    neofetch
    killall
    nixfmt
    htop
    thefuck
  ];

  system.stateVersion = "23.11";
}
