{...}: {
  flake.homeModules.kdeconnect = {pkgs, ...}: {
    home.packages = with pkgs; [
      kdePackages.qttools
    ];

    services.kdeconnect.enable = true;
  };
}
