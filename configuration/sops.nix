{ user, pkgs, ...} :
{
  environment.systemPackages = with pkgs; [
    sops
  ];

  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/${user.username}/.config/sops/age/keys.txt";
  };
}
