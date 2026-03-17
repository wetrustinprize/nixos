{inputs, ...}: {
  flake.homeModules.zed-editor = {...}: {
    nixpkgs.overlays = [
      inputs.zed-editor.overlays.default
    ];
  };
}
