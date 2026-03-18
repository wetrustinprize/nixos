{inputs, ...}: {
  imports = [
    inputs.flake-file.flakeModules.default
  ];

  flake-file = {
    description = "Your flake description";
    inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      import-tree.url = "github:vic/import-tree";
      flake-parts.url = "github:hercules-ci/flake-parts";
      flake-file.url = "github:vic/flake-file";
    };
  };
}
