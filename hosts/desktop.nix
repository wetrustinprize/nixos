{ inputs, pkgs, ... }:
{
  programs.hyprland.enable = true;

  programs.thunar = {
    enable = true;
    plugins = [
      pkgs.xfce.thunar-archive-plugin
    ];
  };

  services.xserver.enable = true;

  boot.plymouth = {
    enable = true;
    theme = "nixos-bgrt";
    themePackages = [ pkgs.nixos-bgrt-plymouth ];
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  security.polkit.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.code-new-roman
    nerd-fonts.jetbrains-mono
  ];

  services.displayManager.ly = {
    enable = true;
    settings = {
      "clear_password" = true;
      "vi_mode" = true;
    };
  };

  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Added this to be able to use controllers in games
  # https://www.perplexity.ai/search/help-me-figure-it-out-why-my-p-nxYYKmjsT.WenPQTKxc.LA
  services.udev.packages = with pkgs; [ game-devices-udev-rules android-udev-rules ];
  hardware.uinput.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
    headsetcontrol
  ];

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
