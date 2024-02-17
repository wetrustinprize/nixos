{ pkgs, lib, ... }: {
  home.packages = with pkgs; [ steam itch prismlauncher lutris ];
}
