{ pkgs, ... }: {
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  environment.systemPackages = with pkgs; [
    easyeffects
  ];
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}