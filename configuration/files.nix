{ pkgs, ... } :
{
  environment.systemPackages = with pkgs; [
    zip
    unzip
    p7zip
    usbutils
    udiskie
    file-roller
  ];

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-media-tags-plugin
      thunar-volman
    ];
  };

  programs.xfconf.enable = true; # to save thunar settings

  services = {
    gvfs.enable = true;    # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images
    udisks2.enable = true; # Auto mount usb drives
  };
}
