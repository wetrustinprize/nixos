{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    kando
  ];

  home.file.".config/kando/menus.json" = {
    text = builtins.toJSON {
      menus = [
        {
          shortcut = "Control+Space";
          shortcutID = "app-launch";
          centered = false;
          root = {
            type = "submenu";
            name = "App Launch";
            icon = "circle";
            iconTheme = "material-symbols-rounded";
            children = [
              {
                type = "command";
                data = {
                  command = "code --ozone-platform=x11";
                  delayed = false;
                };
                name = "IDE";
                icon = "code_blocks";
                iconTheme = "material-symbols-rounded";
              }
              {
                type = "command";
                data = {
                  command = "kitty";
                  delayed = false;
                };
                name = "Terminal";
                icon = "terminal";
                iconTheme = "material-symbols-rounded";
              }
              {
                type = "command";
                data = {
                  command = "thunar";
                  delayed = false;
                };
                name = "File Explorer";
                icon = "folder";
                iconTheme = "material-symbols-rounded";
              }
              {
                type = "command";
                data = {
                  command = "zen";
                  delayed = false;
                };
                name = "Browser";
                icon = "globe";
                iconTheme = "material-symbols-rounded";
              }
            ];
          };
        }
      ];
      templates = [ ];
    };
  };

  home.file.".config/kando/config.json" = {
    text = builtins.toJSON {
      locale = "auto";
      menuTheme = "default";
      darkMenuTheme = "default";
      enableDarkModeForMenuTheme = false;
      soundTheme = "none";
      soundVolume = 0;
      sidebarVisible = false;
      ignoreWriteProtectedConfigFiles = true;
      enableVersionCheck = false;
      zoomFactor = 1;
      trayIconFlavor = "none";
      menuThemeColors = {
        default = {
          "background-color" = "#${config.colorScheme.palette.base01}";
          "text-color" = "#${config.colorScheme.palette.base06}";
          "border-color" = "#${config.colorScheme.palette.base0C}";
          "hover-color" = "#${config.colorScheme.palette.base0C}";
        };
      };
      menuOptions = {
        centerDeadZone = 50;
        minParentDistance = 150;
        dragThreshold = 15;
        fadeInDuration = 150;
        fadeOutDuration = 200;
        enableMarkingMode = true;
        enableTurboMode = true;
        gestureMinStrokeLenght = 150;
        gestureMinStrokeAngle = 20;
        gestureJitterThreshold = 10;
        gesturePauseTimeout = 100;
        fixedStrokeLenght = 0;
        rmbSelectsParent = false;
        gamepadBackButton = 1;
        gamepadCloseButton = 2;
      };
      editorOptions = {
        showSidebarButtonVisible = true;
        showEditorButtonVisible = true;
      };
    };
  };

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "kando"
    ];
    bind = [
      "$mod, SPACE, global, kando:app-launch"
    ];
    windowrule = [
      "noblur, class:kando"
      "opaque, class:kando"
      "size 100% 100%, class:kando"
      "noborder, class:kando"
      "noanim, class:kando"
      "float, class:kando"
      "pin, class:kando"
    ];
  };
}
