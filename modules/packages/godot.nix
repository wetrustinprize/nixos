{inputs, ...}: {
  flake-file.inputs.godot-overlays.url = "github:florianvazelle/godot-overlay";

  flake.homeModules.godot = {
    lib,
    pkgs,
    ...
  }: {
    nixpkgs.overlays = lib.mkAfter (with inputs; [
      godot-overlays.overlays.default
    ]);

    home.packages = lib.mkAfter (with pkgs; [
      godotpkgs.latest
    ]);
  };
}
