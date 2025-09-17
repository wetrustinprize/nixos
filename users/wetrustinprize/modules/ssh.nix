{
  ...
}:
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
        identityFile = "~/.ssh/ssh_client_ed25519_key";
      };
    };
    includes = [
      "~/.ssh/other_config"
    ];
  };
}
