{inputs, ...}: {
  flake-file.inputs.sops-nix.url = "github:Mic92/sops-nix";

  flake.nixosModules.sops = {pkgs, ...}: {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];

    environment.systemPackages = with pkgs; [
      sops
    ];

    sops = {
      defaultSopsFile = ../../secrets.yaml;
      defaultSopsFormat = "yaml";
      age = {
        keyFile = "/etc/sops/age/keys.txt";
        generateKey = false;
      };
    };
  };
}
