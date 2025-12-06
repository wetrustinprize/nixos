{ user, ...} :
{
  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/${user.username}/.config/sops/age/keys.txt";
}
