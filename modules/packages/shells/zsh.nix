{self, ...}: {
  flake.nixosModules.shell-zsh = {...}: {
    imports = [self.nixosModules.shell-defaults];

    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      ohMyZsh = {
        enable = true;
        plugins = [
          "git" # git aliases and functions
          "tldr" # esc + tldr to get tldr suggestions
          "sudo" # double esc to sude
          "zoxide" # zoxide integration
        ];
      };
    };
  };
}
