{...}: {
  flake.homeModules.vicinae = {
    lib,
    config,
    pkgs,
    ...
  }: let
    cfg = config.programs.vicinae;
    extensionsRepo = pkgs.fetchFromGitHub {
      owner = "vicinaehq";
      repo = "extensions";
      rev = "50233dff9dfc70fc6b39c2387687e5661b09f005";
      sha256 = "sha256-GVIbXYiA506LV0cEsG1AA4vTwDJq9R6v6lFFs8z7knY=";
    };
  in {
    options.programs.vicinae = {
      enableNiriIntegration = lib.mkEnableOption "Niri integration (extesion + config)";
      enableZedIntegration = lib.mkEnableOption "Zed integration (extension)";
    };

    config = lib.mkMerge [
      {
        programs.vicinae = {
          enable = true;
          systemd.enable = true;
          extensions =
            lib.map (
              extesion:
                config.lib.vicinae.mkExtension {
                  name = extesion;
                  src = extensionsRepo + "/extensions/${extesion}";
                }
            ) (["wikipedia" "nix"]
              ++ lib.optionals cfg.enableNiriIntegration ["niri"]
              ++ lib.optionals cfg.enableZedIntegration ["zed-recents"]);
        };

        home.packages = with pkgs; lib.optionals cfg.enableZedIntegration [sqlite];
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
