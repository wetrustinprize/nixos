{...}: {
  flake.homeModules.unity = {
    lib,
    pkgs,
    ...
  }: {
    home.packages = lib.mkAfter (with pkgs; [
      unityhub
    ]);
  };
}
