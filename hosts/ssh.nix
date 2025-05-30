{ hostname, username, pkgs, ... }:
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

  system.activationScripts.ssh-client-key.text = ''
    # Create .ssh directory if it doesn't exist
    mkdir -p /home/${username}/.ssh
    chown ${username} /home/${username}/.ssh
    chmod 700 /home/${username}/.ssh

    # Generate client key if it doesn't exist
    if [ ! -f "/home/${username}/.ssh/ssh_client_ed25519_key" ]; then
      echo "Generating new SSH client key..."
      ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -f /home/${username}/.ssh/ssh_client_ed25519_key -N "" -C "${username}@${hostname}"
      chown ${username} /home/${username}/.ssh/ssh_client_ed25519_key*
      chmod 600 /home/${username}/.ssh/ssh_client_ed25519_key
      chmod 644 /home/${username}/.ssh/ssh_client_ed25519_key.pub
      echo "✓ SSH client key generated"
    fi
  '';

  system.activationScripts.ssh-public-keys.text = ''
    echo "Updating SSH public keys..."

    if [ -d "/home/${username}/nixos" ]; then
      # Copy host key
      if cp /etc/ssh/ssh_host_ed25519_key.pub /home/${username}/nixos/hosts/${hostname}/; then
        echo "✓ Successfully copied SSH host public key"
      else
        echo "✗ Failed to copy SSH host public key"
      fi

      # Copy client key if it exists
      if [ -f "/home/${username}/.ssh/ssh_client_ed25519_key.pub" ]; then
        if cp /home/${username}/.ssh/ssh_client_ed25519_key.pub /home/${username}/nixos/hosts/${hostname}/; then
          echo "✓ Successfully copied SSH client public key"
        else
          echo "✗ Failed to copy SSH client public key"
        fi
      else
        echo "! Skipping client key copy - ssh_client_ed25519_key.pub does not exist"
      fi
    else
      echo "! Skipping SSH public key copy - directory /home/${username}/nixos does not exist"
    fi
  '';
}
