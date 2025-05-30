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
    cp /etc/ssh/ssh_host_ed25519_key.pub /home/wetrustinprize/nixos/hosts/${hostname}/
  '';
}