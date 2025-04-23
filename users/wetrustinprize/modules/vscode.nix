{ pkgs, system, ... }:
let
  # this is to fix remote-ssh extension
  forkedNixpkgs =
    import
      (fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/577417344339acac020744052a86f4d112c83e2f.tar.gz";
        sha256 = "11qdhd0dg1kz7v730rqy21fgra8babg2ljds6zmr6wz0ih3d47x0";
      })
      {
        inherit system;
        config.allowUnfree = true;
      };
in
{
  nixpkgs.overlays = [
    (self: super: {
      vscode-extensions = super.vscode-extensions // {
        ms-vscode-remote.remote-ssh = forkedNixpkgs.vscode-extensions.ms-vscode-remote.remote-ssh;
      };
    })
  ];

  home.packages = with pkgs; [
    vscode
  ];

  # FIXME: Look after why code is so bad at wayland
  # this wasn't an issue in the past
  xdg.desktopEntries."code" = {
    name = "Visual Studio Code";
    genericName = "Text Editor";
    exec = "code %F --ozone-platform=x11";
  };

  programs.vscode = {
    enable = true;

    profiles.wetrustinprize = {
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;

      extensions = with pkgs.vscode-extensions; [
        # theme
        arcticicestudio.nord-visual-studio-code
        pkief.material-icon-theme
        pkief.material-product-icons

        # behaviour
        vscodevim.vim
        fill-labs.dependi
        eamodio.gitlens
        wakatime.vscode-wakatime
        naumovs.color-highlight
        gruntfuggly.todo-tree
        jgclark.vscode-todo-highlight
        oderwat.indent-rainbow
        ms-vsliveshare.vsliveshare
        aaron-bond.better-comments
        ms-vscode-remote.remote-ssh
        editorconfig.editorconfig

        # toml
        tamasfe.even-better-toml

        # dotenv
        mikestead.dotenv

        # nix
        bbenoist.nix

        # javascript/typescript
        dbaeumer.vscode-eslint
        styled-components.vscode-styled-components

        # rust
        rust-lang.rust-analyzer

        # gdscript
        geequlim.godot-tools
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
