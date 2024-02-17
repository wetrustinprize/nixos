{ pkgs, lib, ... }: {
  home.packages = with pkgs; [ vscode unityhub android-studio ];
}
