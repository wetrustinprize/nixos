{...}: {
  flake.nixosModules.proton-suite = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      proton-vpn-cli
      proton-pass-cli
    ];
  };

  flake.homeModules.proton-suite = {pkgs, ...}: {
    home.packages = with pkgs; [
      proton-pass
      protonvpn-gui
    ];
  };
}
