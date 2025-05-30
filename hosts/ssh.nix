{ hostname, username, lib, ... }:
let
  hostsDir = ./.;

  hosts = lib.filter (host: host != hostname) (
    builtins.attrNames (lib.filterAttrs (_: type: type == "directory") (builtins.readDir hostsDir))
  );

  publicKeys = lib.concatMap (
    host:
    let
      hostPath = "${hostsDir}/${host}";
      files = builtins.attrNames (
        lib.filterAttrs (_: type: type == "regular") (builtins.readDir hostPath)
      );
      pubFiles = lib.filter (f: lib.hasSuffix ".pub" f) files;
    in
    map (pub: {
      name = "ssh/authorized_keys.d/${host}_${pub}";
      value = {
        source = "${hostPath}/${pub}";
      };
    }) pubFiles
  ) hosts;
in
{
  programs.ssh.startAgent = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  system.activationScripts.ssh-key-chown.text = ''
    chown -R ${username} /etc/ssh/ssh_host_ed25519*
  '';

  system.activationScripts.ssh-public-keys.text = ''
    echo "Updating SSH public keys..."

    if [ -d "/home/${username}/nixos" ]; then
      if cp /etc/ssh/ssh_host_ed25519_key.pub /home/${username}/nixos/hosts/${hostname}/; then
        echo "✓ Successfully copied SSH public key"
      else
        echo "✗ Failed to copy SSH public key"
      fi
    else
      echo "! Skipping SSH public key copy - directory /home/${username}/nixos does not exist"
    fi
  '';

  environment.etc = lib.listToAttrs publicKeys;
}
