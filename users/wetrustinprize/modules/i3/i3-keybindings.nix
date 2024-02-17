mod: {
  # Spawn
  "${mod}+Return" = "exec alacritty";
  "${mod}+F2" = "exec vivaldi";
  "${mod}+F3" = "exec thunar";

  # Kill 
  "${mod}+Shift+c" = "kill";
  "${mod}+Shift+x" = "--release exec --no-startup-id xkill";

  # Focus
  "${mod}+h" = "focus left";
  "${mod}+j" = "focus down";
  "${mod}+k" = "focus up";
  "${mod}+l" = "focus right";

  # Layouts
  "${mod}+f" = "fullscreen toggle";
  "${mod}+s" = "layout stacking";
  "${mod}+w" = "layout tabbed";
  "${mod}+e" = "layout split";

  # Tilling / Float
  "${mod}+space" = "focus mode_toggle";
  "${mod}+Shift+space" = "floating toggle";
  "${mod}+Shift+s" = "sticky toggle";

  # Container
  "${mod}+a" = "focus parent";

  # Switch workspaces
  "${mod}+b" = "workspace back_and_forth";
  "${mod}+1" = "workspace 1";
  "${mod}+2" = "workspace 2";
  "${mod}+3" = "workspace 3";
  "${mod}+4" = "workspace 4";
  "${mod}+5" = "workspace 5";
  "${mod}+6" = "workspace 6";
  "${mod}+7" = "workspace 7";
  "${mod}+8" = "workspace 8";
  "${mod}+9" = "workspace 9";

  # Move to workspace
  "${mod}+Ctrl+1" = "move container to workspace 1";
  "${mod}+Ctrl+2" = "move container to workspace 2";
  "${mod}+Ctrl+3" = "move container to workspace 3";
  "${mod}+Ctrl+4" = "move container to workspace 4";
  "${mod}+Ctrl+5" = "move container to workspace 5";
  "${mod}+Ctrl+6" = "move container to workspace 6";
  "${mod}+Ctrl+7" = "move container to workspace 7";
  "${mod}+Ctrl+8" = "move container to workspace 8";
  "${mod}+Ctrl+9" = "move container to workspace 9";

  # Move to workspace and follow
  "${mod}+Shift+1" = "move container to workspace 1; workspace 1";
  "${mod}+Shift+2" = "move container to workspace 2; workspace 2";
  "${mod}+Shift+3" = "move container to workspace 3; workspace 3";
  "${mod}+Shift+4" = "move container to workspace 4; workspace 4";
  "${mod}+Shift+5" = "move container to workspace 5; workspace 5";
  "${mod}+Shift+6" = "move container to workspace 6; workspace 6";
  "${mod}+Shift+7" = "move container to workspace 7; workspace 7";
  "${mod}+Shift+8" = "move container to workspace 8; workspace 8";
  "${mod}+Shift+9" = "move container to workspace 9; workspace 9";

  # Rofi
  "${mod}+p" = "exec --no-startup-id rofi -show drun";
  "${mod}+Shift+p" = "exec --no-startup-id rofi -show run";

  # Print Screen
  "Print" = "--release exec --no-startup-id i3-scrot -sc";
  "Shift+Print" = "--release exec --no-startup-id i3-scrot -wc";
  "Ctrl+Print" = "--release exec --no-startup-id i3-scrot -dc";

  #i3
  "${mod}+q" = "reload";
  "${mod}+shift+q" = "restart";
}
