{...}: {
  flake.nixosModules.nixos-default = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      git # do I need to explain?
      dnsutils # dns utils
      delta # diff tool
      tldr # awesome tool to tldr man pages
      dysk # better ux for disk usage info
      jq # json query
      croc # local file transfer
      htop-vim # htop with vim bindings
      ripgrep # better than grep
      bat # the cat with wings!
      fd # better than find
      xh # other http client
      dust # better than du
      hyperfine # benchmarking tool
      fselect # find files with sql-like syntax
      tokei # count lines of code
      mprocs # run multiple processes in parallel
    ];
  };
}
