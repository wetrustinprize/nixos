{ user, ... }: {
  imports = [
    ../../configuration

    ./hardware-configuration.nix
  ];

  sops.secrets."ssh/poseidon/private" = { # ssh private key
    owner = "${user.username}";
    mode = "600";
    path = "/home/${user.username}/.ssh/id_ed25519";
  };
  sops.secrets."ssh/poseidon/public" = { # ssh public key
    owner = "${user.username}";
    mode = "644";
    path = "/home/${user.username}/.ssh/id_ed25519.pub";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };
}
