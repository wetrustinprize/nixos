{ pkgs, lib, ... }: {
  programs.chromium = {
    enable = true;
    extension = [{
      id = "gighmmpiobklfepjocnamgkkbiglidom";
    }; # Adblock
    {
      id = "nngceckbapebfimnlniiiahkandclblb"
    }; # Bitwarden
    {
      id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"
    }; # Dark reader
      ];
  };
}
