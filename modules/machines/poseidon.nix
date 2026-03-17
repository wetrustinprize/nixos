{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.poseidon = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hardware
      self.nixosModules.boot
      self.nixosModules.nix-settings
      self.nixosModules.locale
      self.nixosModules.networking

      #shell
      self.nixosModules.shell-zsh

      # gpu
      self.nixosModules.nvidia

      # desktop
      self.nixosModules.login
      self.nixosModules.audio
      self.nixosModules.graphics

      # users
      self.nixosModules.home-manager
      self.nixosModules.user-wetrustinprize

      # packages
      self.nixosModules.niri
      self.nixosModules.stylix
      self.nixosModules.zed-editor

      # nyx additional configuration
      {
        nyx.networking.hostname = "poseidon";

        nyx.users.wetrustinprize.homeManagerModules = [
          self.homeModules.nix-settings
          self.homeModules.niri
          self.homeModules.alacritty
          self.homeModules.firefox
          self.homeModules.noctalia
          self.homeModules.zed-editor

          # nyx home additional configuration
          {
            nyx.noctalia.niri.enable = true;
          }

          # noctalia additional configuration
          {
            programs.noctalia-shell.settings.notifications.monitors = ["HDMI-A-2"];
          }

          # niri additional configuration
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
        ];

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
  };
}
