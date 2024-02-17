{ pkgs, ... }: {
  users.users.wetrustinprize = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.nushell;
  };

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
    nushell
  ];

  system.stateVersion = "23.11";
}
