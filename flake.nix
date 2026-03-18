# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  description = "Your flake description";

  outputs = inputs: import ./outputs.nix inputs;

  inputs = {
    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    flake-file.url = "github:vic/flake-file";
    flake-parts.url = "github:hercules-ci/flake-parts";
    godot-overlays.url = "github:florianvazelle/godot-overlay";
    home-manager.url = "github:nix-community/home-manager/master";
    import-tree.url = "github:vic/import-tree";
    niri.url = "github:sodiboo/niri-flake";
    nix-auto-follow = {
      url = "github:fzakaria/nix-auto-follow";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database.url = "github:nix-community/nix-index-database";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    noctalia.url = "github:noctalia-dev/noctalia-shell";
    sops-nix.url = "github:Mic92/sops-nix";
    stylix.url = "github:nix-community/stylix";
  };
}
