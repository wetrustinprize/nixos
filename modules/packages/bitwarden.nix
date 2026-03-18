{...}: {
  flake.nixosModules.bitwarden = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      bitwarden-cli
    ];
  };

  flake.homeModules.bitwarden = {pkgs, ...}: {
    home.packages = with pkgs; [
      bitwarden-desktop
    ];
  };
}
