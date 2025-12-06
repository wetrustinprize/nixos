{ inputs, ... }: {
  imports = [
    ../../configuration

    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-e14-amd
  ];

  services.xserver.xkb = {
    layout = "br";
    variant = "thinkpad";
  };
}
