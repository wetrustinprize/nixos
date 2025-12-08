{ user, pkgs, ...} :
{
  environment.systemPackages = with pkgs; [
    sops
  ];

  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/${user.username}/.config/sops/age/keys.txt";
}
