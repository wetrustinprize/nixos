{lib, ...}: {
  libParts.mkUser = args @ {...}: let
    cfg =
      (lib.evalModules {
        modules = [
          ({lib, ...}: {
            options = {
              username = lib.mkOption {
                type = lib.types.str;
              };

              extraGroups = lib.mkOption {
                type = lib.types.listOf lib.types.str;
                default = [];
              };
            };

            config = args;
          })
        ];
      }).config;
  in
    {
      config,
      lib,
      pkgs,
      ...
    }: let
      host = config.networking.hostName;
      hasSSH =
        ../../secrets.yaml
        |> (file:
          pkgs.runCommand "converted-yaml.json" {} ''
            ${pkgs.yj}/bin/yj < "${file}" > "$out"
          '')
        |> builtins.readFile
        |> builtins.fromJSON
        |> (s: lib.hasAttrByPath [host "ssh"] s)
        |> (v: lib.warnIf (!v) "No SSH secrets found for host ${host} user ${cfg.username}." v);
    in
      lib.mkMerge [
        {
          home-manager.users.${cfg.username}.nixpkgs.config.allowUnfree = true;
          users = {
            users.${cfg.username} = {
              isNormalUser = true;
              initialPassword = "password"; # only used for first boot after getting the .age key for sops
              hashedPasswordFile = config.sops.secrets."user-password".path; # after .age is provided
              extraGroups = cfg.extraGroups;
            };
          };
        }
        (lib.mkIf hasSSH {
          sops.secrets."${host}/ssh/private" = {
            owner = "wetrustinprize";
            mode = "600";
            path = "/home/${cfg.username}/.ssh/id_ed25519";
          };
          sops.secrets."${host}/ssh/public" = {
            owner = "wetrustinprize";
            mode = "644";
            path = "/home/${cfg.username}/.ssh/id_ed25519.pub";
          };
        })
      ];
}
