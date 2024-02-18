{ ... }: {
  imports = [ ./common.nix ];

  programs.bash = { enable = true; };

  programs.zoxide.enableBashIntegration = true;
  programs.starship.enableBashIntegration = true;
}
