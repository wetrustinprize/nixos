{ pkgs, ... }: {
  services.displayManager.defaultSession = "none+i3";
  services.xserver = {
    enable = true;
    displayManager = {
      lightdm = {
        enable = true;
        greeter.enable = true;
        greeters.mini = {
          enable = true;
          user = "wetrustinprize";
          extraConfig = ''
            [greeter]
            show-sys-info=true
            password-alignment = center

            [greeter-theme]
            font-weight = regular

            text-color=#eceff4
            error-color=#bf616a
            background-image = ""
            background-color = "#2e3440"

            window-color = "#4c566a"
            border-color = "#eceff4"
            border-width = 1px

            password-color = "#2e3440"
            password-background-color = "#eceff4"
            password-border-width = 0px
          '';
        };
      };
    };
    desktopManager.wallpaper = {
      mode = "scale";
      combineScreens = true;
    };
    windowManager.i3 = { enable = true; };
  };
}
