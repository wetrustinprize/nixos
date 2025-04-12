{ pkgs, ... }: {
  home.packages = with pkgs; [
    vscode
  ];

  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;

    profiles.wetrustinprize = {
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;

      extensions = with pkgs.vscode-extensions; [
        vscodeviom.vim
        arcticicestudio.nord-visual-studio-code
      ];
    };
  }
}