{ hostname, username, ... }:
{
  programs.ssh.startAgent = true;

  services.openssh = {
    enable = true;
    authorizedKeysInHomedir = true;
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
}
