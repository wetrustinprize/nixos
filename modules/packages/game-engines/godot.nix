{inputs, ...}: {
  flake-file.inputs.godot-overlay.url = "github:florianvazelle/godot-overlay";

  flake.homeModules.godot = {
    lib,
    pkgs,
    ...
  }: {
    nixpkgs.overlays = lib.mkAfter [
      inputs.godot-overlay.overlays.default
    ];

    home.packages = lib.mkAfter (with pkgs; [
      godotpkgs.latest
    ]);
  };
}
