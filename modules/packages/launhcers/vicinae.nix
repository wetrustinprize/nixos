{...}: {
  flake.homeModules.vicinae = {
    lib,
    config,
    pkgs,
    ...
  }: let
    cfg = config.programs.vicinae;
    raycastRepo = {
      rev = "d7f68ce8eb9759f2c3a9c1bdfe5991b14f55c6f7";
      sha256 = "sha256-YcjrBdqeNgC116LKzfPdz1AmupxwvkmwFBbzBDK7wCI=";
    };
    extensionsRepo = pkgs.fetchFromGitHub {
      owner = "vicinaehq";
      repo = "extensions";
      rev = "50233dff9dfc70fc6b39c2387687e5661b09f005";
      sha256 = "sha256-GVIbXYiA506LV0cEsG1AA4vTwDJq9R6v6lFFs8z7knY=";
    };
  in {
    options.programs.vicinae = {
      enableNiriIntegration = lib.mkEnableOption "Niri integration (extesion + config)";
      enableBitwardenIntegration = lib.mkEnableOption "Bitwarden integration (extension)";
    };

    config = lib.mkMerge [
      {
        programs.vicinae = {
          enable = true;
          extensions =
            lib.map (
              extesion:
                config.lib.vicinae.mkExtension {
                  name = extesion;
                  src = extensionsRepo + "/extensions/${extesion}";
                }
            ) (["wikipedia" "nix" "zed-recents"]
              ++ lib.optionals cfg.enableNiriIntegration ["niri"]);
        };
      }
      (lib.mkIf
        cfg.enableNiriIntegration
        {
          programs.niri.settings = {
            spawn-at-startup = lib.mkAfter [
              {
                argv = ["vicinae" "server"];
              }
            ];

            binds = {
              "Mod+P" = {
                action.spawn = ["vicinae" "toggle"];
                hotkey-overlay.title = "Toggle app launcher (vicinae)";
              };
              "Mod+Period" = {
                action.spawn = ["vicinae" "vicinae://extensions/vicinae/core/search-emojis"];
                hotkey-overlay.title = "Open emoji picker (vicinae)";
              };
            };
          };
        })
    ];
  };
}
