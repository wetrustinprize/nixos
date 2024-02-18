{ pkgs, ... }: {
  imports = [ ./common.nix ];

  programs.nushell = { enable = true; };

  programs.zoxide.enableNushellIntegration = true;
  programs.starship.enableNushellIntegration = true;
}
