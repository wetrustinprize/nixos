{...}: {
  flake.homeModules.godot = {
    lib,
    pkgs,
    ...
  }: {
    home.packages = lib.mkAfter (with pkgs; [
      godot
    ]);
  };
}
