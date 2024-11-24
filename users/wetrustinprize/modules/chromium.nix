{ pkgs, lib, ... }: {
  programs.chromium = {
    enable = true;
    extensions = [
      {
        id = "gighmmpiobklfepjocnamgkkbiglidom";
      } # Adblock
      {
        id = "nngceckbapebfimnlniiiahkandclblb";
      } # Bitwarden
      {
        id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
      } # Dark reader
    ];
  };
}
