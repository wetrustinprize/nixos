{self, ...}: {
  flake.homeModules.hytale = {pkgs, ...}: {
    imports = [self.homeModules.flatpak];

    services.flatpak.packages = [
      rec {
        appId = "com.hytale.hytale";
        sha256 = "11nnf2xc281fcrjdvm6br3j15bwm9pqxaibl1nm09qwcgq1wbvms";
        bundle = "${pkgs.fetchurl {
          url = "https://launcher.hytale.com/builds/release/linux/amd64/hytale-launcher-latest.flatpak";
          inherit sha256;
        }}";
      }
    ];
  };
}
