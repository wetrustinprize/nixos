{
  inputs,
  self,
  lib,
  ...
}: {
  libParts.mkSystem = args @ {...}: let
    cfg =
      (lib.evalModules {
        modules = [
          ({lib, ...}: {
            options = {
              system = lib.mkOption {
                type = lib.types.str;
              };

              modules = lib.mkOption {
                type = lib.types.listOf lib.types.deferredModule;
                default = [];
              };

              users = lib.mkOption {
                type = lib.types.listOf (lib.types.submodule ({...}: {
                  options = {
                    name = lib.mkOption {
                      type = lib.types.str;
                    };

                    modules = lib.mkOption {
                      type = lib.types.listOf lib.types.str;
                      default = [];
                    };

                    extraModules = lib.mkOption {
                      type = lib.types.listOf lib.types.deferredModule;
                      default = [];
                    };
                  };
                }));
                default = [];
              };
            };

            config = args;
          })
        ];
      }).config;
  in
    inputs.nixpkgs.lib.nixosSystem {
      system = cfg.system;

      modules =
        [
          self.nixosModules.hardware
          self.nixosModules.boot
          self.nixosModules.nix-settings
          self.nixosModules.nixos-default
          self.nixosModules.locale
          self.nixosModules.networking
          self.nixosModules.tailscale
          self.nixosModules.shell-default
          self.nixosModules.users
          self.nixosModules.files
          self.nixosModules.helix
          self.nixosModules.git

          {_module.args = {inherit inputs self;};}
        ]
        # import users
        ++ lib.map (user: self.nixosModules."user-${user.name}") cfg.users
        # import users needed nixosModules
        ++ (cfg.users
          |> lib.concatMap (user: user.modules)
          |> lib.unique
          |> lib.filter (module: lib.hasAttr module self.nixosModules)
          |> lib.map (module: self.nixosModules.${module}))
        # import users homeModules
        ++ (cfg.users
          |> lib.map (user: {
            home-manager.users.${user.name}.imports =
              (user.modules
                |> lib.unique
                |> lib.map (
                  module:
                    if lib.hasAttr module self.homeModules
                    then self.homeModules.${module}
                    else throw "Missing homeModule: ${module}"
                ))
              ++ user.extraModules;
          }))
        # import extra modules
        ++ cfg.modules;
    };
}
