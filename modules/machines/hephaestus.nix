{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.hephaestus = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hardware
      self.nixosModules.boot
      self.nixosModules.nix-settings
      self.nixosModules.locale
      self.nixosModules.networking

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

      # nyx additional configuration
      {
        nyx.networking.hostname = "hephaestus";

        nyx.users.wetrustinprize.homeManagerModules = [
          self.homeModules.nix-settings
          self.homeModules.niri
          self.homeModules.alacritty
          self.homeModules.firefox
          self.homeModules.noctalia

          # nyx home additional configuration
          {
            nyx.noctalia.niri.enable = true;

            programs.niri.settings.debug.render-drm-device = "/dev/dri/card0";
          }
        ];

        environment.sessionVariables = {
          TERMINAL = "alacritty";
          BROWSER = "firefox";
        };
      }
    ];
  };
}
