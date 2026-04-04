{inputs, ...}: {
  flake.nixosModules.audio-share = {...}: {
    imports = [
      "${inputs.my-nixpkgs}/nixos/modules/services/audio/audio-share.nix"
    ];

    nixpkgs.overlays = [
      (final: prev: {
        audio-share =
          final.callPackage
          "${inputs.my-nixpkgs}/pkgs/by-name/au/audio-share/package.nix" {};
      })
    ];

    services.audio-share = {
      enable = true;
      openFirewall = true;
    };
  };
}
