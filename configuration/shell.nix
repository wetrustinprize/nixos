{ pkgs, ... }: {
  console.useXkbConfig = true;

  environment.shells = with pkgs; [ zsh ];

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
