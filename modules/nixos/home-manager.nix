{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.home-manager = {...}: {
    imports = [inputs.home-manager.nixosModules.home-manager];

    home-manager.backupFileExtension = "backup";
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    home-manager.sharedModules = [self.homeModules.nix-settings];
  };
}
