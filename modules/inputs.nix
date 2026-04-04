{inputs, ...}: {
  imports = [
    inputs.flake-file.flakeModules.default
    inputs.flake-file.flakeModules.nix-auto-follow
  ];

  flake-file = {
    description = "Your flake description";
    inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      my-nixpkgs = {
        url = "path:/home/wetrustinprize/Clones/nixpkgs";
        flake = false;
      };
      import-tree.url = "github:vic/import-tree";
      flake-parts.url = "github:hercules-ci/flake-parts";
      flake-file.url = "github:vic/flake-file";
    };
  };
}
