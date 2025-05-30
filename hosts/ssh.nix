{ hostname, ... }: {
  programs.ssh.startAgent = true;

  services.openssh = {
    enable = true;
    authorizedKeysInHomedir = true;
    hostKeys = [{
     path = "/etc/ssh/ssh_host_ed25519_key";
     type = "ed25519";
   }];
  };

  system.activationScripts.ssh-public-keys.text = ''
    echo "Updating SSH public keys..."

    if [ -d "/home/wetrustinprize/nixos" ]; then
      if cp /etc/ssh/ssh_host_ed25519_key.pub /home/wetrustinprize/nixos/hosts/${hostname}/; then
        echo "✓ Successfully copied SSH public key to /home/wetrustinprize/nixos/hosts/${hostname}/"
      else
        echo "✗ Failed to copy SSH public key"
      fi
    else
      echo "! Skipping SSH public key copy - directory /home/wetrustinprize/nixos does not exist"
    fi
  '';
}