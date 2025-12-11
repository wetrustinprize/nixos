{ inputs, pkgs, ... }: {
  imports = [ ./desktop.nix ];

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };
}
