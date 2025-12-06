{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ pamixer ];
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # pipewire needs realtime scheduling access
  security.rtkit.enable = true;
}
