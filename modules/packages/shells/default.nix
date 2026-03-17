{...}: {
  flake.nixosModules.shell-defaults = {pkgs, ...}: {
    console.useXkbConfig = true;

    environment.shells = with pkgs; [zsh];
    users.defaultUserShell = pkgs.zsh;

    programs.starship.enable = true;

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
