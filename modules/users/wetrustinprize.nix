{self, ...}: {
  flake.nixosModules.user-wetrustinprize = self.lib.mkUser {
    username = "wetrustinprize";
    extraGroups = ["wheel"];
  };
}
