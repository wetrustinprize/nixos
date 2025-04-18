{ pkgs, config, ... }:
{
  programs.nushell = {
    enable = true;
    configFile.text = ''
      		$env.config.buffer_editor = "cursor"
      		$env.config.show_banner = false
      		$env.EDITOR = "vim"
      	'';
    extraConfig = "source nix-your-shell.nu";
  };

  programs.zoxide.enableNushellIntegration = true;

  home.file."${config.xdg.configHome}/nushell/nix-your-shell.nu".source =
    pkgs.nix-your-shell.generate-config "nu";
}
