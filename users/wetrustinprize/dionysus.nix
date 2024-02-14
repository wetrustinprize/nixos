{ pkgs, ... }:

{
  home.packages = with pkgs; [ unityhub gimp barrier ];

  services.polybar.script = ''
    killall -q polybar
    while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
    polybar --reload primary &
  '';
}
