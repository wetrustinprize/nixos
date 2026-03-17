{...}: {
  flake.nixosModules.audio = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [pamixer];

    # pipewire needs realtime scheduling access
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;

      # below these lines are configurations
      # to make the mic not lagg the whole computer
      wireplumber.extraConfig."99-disable-suspend" = {
        "monitor.alsa.rules" = [
          {
            matches = [
              {"node.name" = "~alsa_input.*";}
              {"node.name" = "~alsa_output.*";}
            ];
            actions = {
              update-props = {
                "session.suspend-timeout-seconds" = 0;
              };
            };
          }
        ];
      };
      extraConfig = {
        pipewire = {
          "99-no-mic-gain" = {
            "context.properties" = {
              "audio.no-dsp" = true;
            };
          };
          "99-quantum" = {
            "context.properties" = {
              "default.clock.rate" = 48000;
              "default.clock.min-quantum" = 1024;
              "default.clock.max-quantum" = 8192;
            };
          };
        };
        pipewire-pulse."99-quantum" = {
          context.modules = [
            {
              name = "libpipewire-module-protocol-pulse";
              args = {
                pulse.min.quantum = "1024/48000";
                pulse.default.quantum = "1024/48000";
                pulse.max.quantum = "8192/48000";
              };
            }
          ];
        };
      };
    };
  };
}
