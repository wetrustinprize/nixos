{
  pkgs,
  system,
  inputs,
  username,
  ...
}:
{
  nixpkgs.overlays = [
    inputs.nix-vscode-extensions.overlays.default
  ];

  # FIXME: Look after why code is so bad at wayland
  # this wasn't an issue in the past
  xdg.desktopEntries."cursor" = {
    name = "Cursor";
    genericName = "Text Editor";
    exec = "cursor --ozone-platform=x11";
  };

  programs.vscode = {
    enable = true;

    package = pkgs.code-cursor;

    profiles.default = {
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      userSettings = {
        "window.newWindowProfile" = "${username}";
      };
    };

    profiles.${username} = {
      extensions = with pkgs.nix-vscode-extensions; [
        # theme
        vscode-marketplace.arcticicestudio.nord-visual-studio-code
        vscode-marketplace.pkief.material-icon-theme
        vscode-marketplace.pkief.material-product-icons

        # behaviour
        vscode-marketplace.vscodevim.vim
        vscode-marketplace.fill-labs.dependi
        vscode-marketplace.eamodio.gitlens
        vscode-marketplace.wakatime.vscode-wakatime
        vscode-marketplace.naumovs.color-highlight
        vscode-marketplace.gruntfuggly.todo-tree
        vscode-marketplace.jgclark.vscode-todo-highlight
        vscode-marketplace.oderwat.indent-rainbow
        vscode-marketplace.ms-vsliveshare.vsliveshare
        vscode-marketplace.aaron-bond.better-comments
        open-vsx.jeanp413.open-remote-ssh
        vscode-marketplace.editorconfig.editorconfig

        # toml
        vscode-marketplace.tamasfe.even-better-toml

        # dotenv
        vscode-marketplace.mikestead.dotenv

        # nix
        vscode-marketplace.bbenoist.nix

        # html/css
        vscode-marketplace.moalamri.inline-fold

        # javascript/typescript
        vscode-marketplace.dbaeumer.vscode-eslint
        vscode-marketplace.bradlc.vscode-tailwindcss

        # react
        vscode-marketplace.styled-components.vscode-styled-components

        # vue
        vscode-marketplace.vue.volar

        # rust
        vscode-marketplace.rust-lang.rust-analyzer

        # gdscript
        vscode-marketplace.geequlim.godot-tools
      ];

      userSettings = {
        "workbench.colorTheme" = "Nord";
        "workbench.productIconTheme" = "material-product-icons";
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.sideBar.location" = "right";
        "workbench.navigationControl.enabled" = false;
        "workbench.layoutControl.enabled" = false;
        "window.customTitleBarVisibility" = "never";
        "window.commandCenter" = false;
        "editor.minimap.enabled" = false;
        "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
        "editor.formatOnSave" = true;
        "editor.formatOnSaveMode" = "modifications";
        "editor.fontLigatures" = true;
        "editor.wordWrap" = "on";
        "chat.commandCenter.enabled" = false;
        "workbench.startupEditor" = "none";
        "files.autoSave" = "onWindowChange";
        "git.confirmSync" = false;
        "git.autoStash" = true;
        "git.autofetch" = "all";
        "git.followTagsWhenSync" = true;
        "terminal.integrated.fontLigatures.enabled" = true;
        "dependi.extras.silenceUpdateMessages" = true;
        "extensions.autoCheckUpdates" = false;
        "update.mode" = "none";

        # Vim
        "vim.leader" = "<space>";
        "vim.useSystemClipboard" = true;
        "vim.normalModeKeyBindingsNonRecursive" = [
          # Rename symbol
          {
            "before" = [
              "<leader>"
              "r"
              "s"
            ];
            commands = [ "editor.action.rename" ];
          }

          # Toggle terminal
          {
            "before" = [
              "<leader>"
              "t"
            ];
            commands = [ "workbench.action.terminal.toggleTerminal" ];
          }

          # Open file search
          {
            "before" = [
              "<leader>"
              "<leader>"
            ];
            "commands" = [ "workbench.action.quickOpen" ];
          }

          # Open command pallet
          {
            "before" = [
              "<leader>"
              "p"
            ];
            "commands" = [ "workbench.action.showCommands" ];
          }

          # Better window control
          {
            "before" = [
              "<leader>"
              "w"
            ];
            "after" = [
              "<ctrl>"
              "w"
            ];
          }
        ];

        # Smoother scrollings
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.smoothScrolling" = "on";
        "workbench.list.smoothScrolling" = "on";
        "terminal.integrated.smoothScrolling" = "on";
        "editor.cursorBlinking" = "smooth";
        "indentRainbow.colors" = [
          "rgba(191, 97, 106, 0.1)"
          "rgba(208, 135, 112, 0.1)"
          "rgba(235, 203, 139, 0.1)"
          "rgba(163, 190, 140, 0.1)"
          "rgba(180, 142, 173, 0.1)"
        ];
      };
    };
  };
}
