{...}: {
  flake.nixosModules.shell-default = {pkgs, ...}: {
    console.useXkbConfig = true;

    environment.shells = with pkgs; [fish];
    users.defaultUserShell = pkgs.fish;

    programs.starship.enable = true;
    programs.direnv.enable = true;
    programs.zoxide.enable = true;

    programs.fish = {
      enable = true;
    };
  };
}
