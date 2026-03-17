{self, ...}: {
  flake.nixosModules.users = {...}: {
    imports = [self.nixosModules.sops];

    sops.secrets."user-password".neededForUsers = true;

    users = {
      mutableUsers = false;
    };
  };
}
