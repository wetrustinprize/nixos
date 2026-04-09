{self, ...}: {
  flake.nixosConfigurations.poseidon = self.lib.mkSystem {
    system = "x86_64_linux";
    modules = [
      self.nixosModules.home-manager
      self.nixosModules.stylix
      self.nixosModules.nvidia
      self.nixosModules.login
      self.nixosModules.audio
      self.nixosModules.graphics
      self.nixosModules.steam
      self.nixosModules.thunar
      self.nixosModules.tablet
      self.nixosModules.glances

      # additional configuration
      {
        networking.hostName = "poseidon";

        environment.sessionVariables = {
          TERMINAL = "alacritty";
          BROWSER = "firefox";
          EDITOR = "zeditor --wait";
        };
      }

      # hardware configuration
      ({lib, ...}: {
        powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";

        boot.initrd.availableKernelModules = [
          "nvme"
          "xhci_pci"
          "ahci"
          "usb_storage"
          "usbhid"
          "sd_mod"
        ];

        boot.kernelModules = ["kvm-amd"];

        fileSystems."/" = {
          device = "/dev/disk/by-uuid/150ed8a2-424a-409b-9816-3c802f7f4f60";
          fsType = "ext4";
        };

        fileSystems."/boot" = {
          device = "/dev/disk/by-uuid/973D-A4B0";
          fsType = "vfat";
          options = [
            "fmask=0022"
            "dmask=0022"
          ];
        };

        swapDevices = [];
      })
    ];
    users = [
      {
        name = "wetrustinprize";
        modules = [
          "alacritty"
          "firefox"
          "zed-editor"
          "spicetify"
          "unity"
          "godot"
          "nixcord"
          "noctalia"
          "niri"
          "kdeconnect"
          "vicinae"
          "proton-suite"
          "archive"
          "helix"
          "obs"
          "audio"
        ];
        extraModules = [
          # noctalia configs
          {
            programs.noctalia-shell.enableNiriIntegration = true;
            programs.noctalia-shell.settings.notifications.monitors = ["HDMI-A-2"];
          }

          # vicinae configs
          {
            programs.vicinae.enableNiriIntegration = true;
            programs.vicinae.enableZedIntegration = true;
          }

          # niri configs
          {
            programs.niri.settings.outputs = {
              "DP-3" = {
                mode = {
                  height = 1080;
                  width = 1920;
                  refresh = 119.879; # having issues with the monitor, have to lower the refresh rate
                };
                position = {
                  x = 1920;
                  y = 0;
                };
                focus-at-startup = true;
              };

              "HDMI-A-2" = {
                mode = {
                  height = 1080;
                  width = 1920;
                  refresh = 60.0;
                };
                position = {
                  x = 0;
                  y = 0;
                };
              };
            };
          }

          # other packages that don't have modules yet
          ({pkgs, ...}: {
            home.packages = with pkgs; [
              slack
              beeper
              obsidian
              homebank
              gitkraken
              fastmail-desktop
              bottles
              prismlauncher
              blender
              pureref
              libreoffice
              material-maker
              krita
              texturepacker
            ];
          })
        ];
      }
    ];
  };
}
