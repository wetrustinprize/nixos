{...}: {
  flake.nixosModules.archive = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      zip
      unzip
    ];
  };

  flake.homeModules.archive = {pkgs, ...}: {
    home.packages = with pkgs; [
      file-roller
    ];
  };
}
