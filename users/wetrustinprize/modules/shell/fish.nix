{ ... }: {
  programs.fish = { enable = true; };

  programs.zoxide.enableFishIntegration = true;
  programs.starship.enableFishIntegration = true;
}
