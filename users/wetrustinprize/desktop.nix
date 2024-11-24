{ pkgs, lib, ... }:

{
  imports = [
    ./modules/i3/i3.nix
    ./modules/polybar/polybar.nix
    ./modules/alacritty.nix
    ./modules/dunst.nix
    ./modules/rofi.nix
    ./modules/chromium.nix
  ];
}
