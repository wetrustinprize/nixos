{
  inputs,
  self,
  lib,
  ...
}: {
  flake-file.inputs.home-manager.url = lib.mkDefault "github:nix-community/home-manager/master";

  flake.nixosModules.home-manager = {...}: {
    imports = [inputs.home-manager.nixosModules.home-manager];

    home-manager.backupFileExtension = "backup";
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    home-manager.sharedModules = [self.homeModules.nix-settings];
  };
}
