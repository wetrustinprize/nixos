{self, ...}: {
  flake.nixosModules.user-wetrustinprize = {
    config,
    lib,
    pkgs,
    ...
  }: let
    host = config.networking.hostName;
    cfg = config.users.wetrustinprize;
    hasSSH =
      ../../secrets.yaml
      |> (file:
          pkgs.runCommand "converted-yaml.json" {} ''
            ${pkgs.yj}/bin/yj < "${file}" > "$out"
          '')
      |> builtins.readFile
      |> builtins.fromJSON
      |> (s: lib.hasAttrByPath [host "ssh"] s)
      |> (v: lib.warnIf (!v) "No SSH secrets found for host ${host}." v);
  in {
    imports = [self.nixosModules.users];

    options.users.wetrustinprize = {
      homeManagerModules = lib.mkOption {
        type = lib.types.listOf lib.types.anything;
        default = [];
        description = "The modules to be imported in home-manager";
      };
    };

    config = lib.mkMerge [
      {
        home-manager.users.wetrustinprize = {
          imports = cfg.homeManagerModules;
        };

        users = {
          users.wetrustinprize = {
            isNormalUser = true;
            initialPassword = "change-me"; # only used for first boot after getting the .age key for sops
            hashedPasswordFile = config.sops.secrets."user-password".path; # after .age is provided
            extraGroups = [
              "wheel" # can sudo
              "video" # access to video
            ];
          };
        };
      }
      (lib.mkIf hasSSH {
        sops.secrets."${host}/ssh/private" = {
          owner = "wetrustinprize";
          mode = "600";
          path = "/home/wetrustinprize/.ssh/id_ed25519";
        };
        sops.secrets."${host}/ssh/public" = {
          owner = "wetrustinprize";
          mode = "644";
          path = "/home/wetrustinprize/.ssh/id_ed25519.pub";
        };
      })
    ];
  };
}
