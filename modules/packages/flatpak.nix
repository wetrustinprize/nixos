{inputs, ...}: {
  flake-file.inputs.nix-flatpak.url = "github:gmodena/nix-flatpak";

  flake.homeModules.flatpak = {...}: {
    imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];

    services.flatpak = {
      enable = true;
      update.auto.enable = false;
      uninstallUnmanaged = true;
    };
  };
}
