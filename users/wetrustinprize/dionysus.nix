{ pkgs, ... }:

{
  home.packages = with pkgs; [ unityhub gimp ];

  services.barrier.client = {
    enable = true;
    name = "dionysus";
  };

  services.polybar.script = ''
    killall -q polybar
    while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
    polybar --reload primary &
  '';
}
