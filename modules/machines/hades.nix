{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.hades = self.lib.mkSystem {
    system = "x86_64_linux";
    modules = [
      self.nixosModules.home-manager
      self.nixosModules.stylix
      self.nixosModules.login
      self.nixosModules.audio
      self.nixosModules.graphics
      self.nixosModules.steam
      self.nixosModules.thunar

      # nixos hardware config
      {
        imports = [
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-e14-amd
        ];
      }

      # hardware configuration
      ({
        lib,
        config,
        ...
      }: {
        boot.initrd.availableKernelModules = [
          "nvme"
          "xhci_pci"
          "usb_storage"
          "sd_mod"
        ];
        boot.initrd.kernelModules = [];
        boot.kernelModules = ["kvm-amd"];
        boot.extraModulePackages = [];

        fileSystems."/" = {
          device = "/dev/disk/by-uuid/a6b4f082-3c8f-43ad-9fc6-a839fa1b807e";
          fsType = "ext4";
        };

        fileSystems."/boot" = {
          device = "/dev/disk/by-uuid/B155-FC6D";
          fsType = "vfat";
          options = [
            "fmask=0077"
            "dmask=0077"
          ];
        };

        swapDevices = [
          {device = "/dev/disk/by-uuid/bd1a9271-a682-45b2-852d-a3cf683899a3";}
        ];

        networking.useDHCP = lib.mkDefault true;
        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
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
        ];
        extraModules = [
          # vicinae configs
          {
            programs.vicinae.enableNiriIntegration = true;
            programs.vicinae.enableZedIntegration = true;
          }

          # noctalia configs
          ({lib, ...}: {
            programs.noctalia-shell.enableNiriIntegration = true;

            programs.noctalia-shell.settings = {
              bar = {
                widgets = {
                  right = lib.mkAfter [
                    {
                      id = "Battery";
                    }
                    {
                      id = "Brightness";
                    }
                    {
                      id = "WiFi";
                    }
                    {
                      id = "Bluetooth";
                    }
                  ];
                };
              };
            };
          })
        ];
      }
    ];
  };
}
