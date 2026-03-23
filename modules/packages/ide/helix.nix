{...}: {
  flake.nixosModules.helix = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [evil-helix];
  };

  flake.homeModules.helix = {pkgs, ...}: {
    programs.helix = {
      enable = true;
      package = pkgs.evil-helix;
    };
  };
}
