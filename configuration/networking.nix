{ pkgs, hostname, ... } : {
  networking = {
    # allow automatic ip assignment when connecting to a network
    useDHCP = pkgs.lib.mkDefault true;
    networkmanager.enable = true;
    firewall.enable = true;

    # let wifi info be NOT declarative, allowing user to configure wifi.
    wireless.userControlled.enable = true;
    wireless.iwd.enable = true;
    networkmanager.wifi.backend = "iwd";
    hostName = hostname;
  };

  # tui to manage wifi networks
  environment.systemPackages = with pkgs; [ impala ];
}
