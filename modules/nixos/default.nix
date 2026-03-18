{...}: {
  flake.nixosModules.nixos-default = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      git
      delta
      tldr
      dysk
      evil-helix
      bat
      jq
      ripgrep
      croc
    ];
  };
}
