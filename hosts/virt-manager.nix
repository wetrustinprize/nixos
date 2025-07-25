{ lib, username, pkgs, ... }:
{
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  virtualisation.spiceUSBRedirection.enable = true;

  users.users.${username}.extraGroups = lib.mkAfter [ "libvirtd" ];
}
