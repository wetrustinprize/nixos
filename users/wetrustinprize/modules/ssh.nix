{
  config,
  lib,
  hostname,
  ...
}:
{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "*" = {
        identityFile = "~/.ssh/ssh_client_ed25519_key";
      };
    };
    includes = [
      "~/.ssh/other_config"
    ];
  };
}
