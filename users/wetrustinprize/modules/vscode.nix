{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vscode
  ];

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
        danielsanmedium.dscodegpt
        eamodio.gitlens
        wakatime.vscode-wakatime
        naumovs.color-highlight
        gruntfuggly.todo-tree
        jgclark.vscode-todo-highlight
        oderwat.indent-rainbow
        ms-vsliveshare.vsliveshare
        aaron-bond.better-comments
        ms-vscode-remote.remote-ssh

        # nix
        bbenoist.nix

        # javascript/typescript
        dbaeumer.vscode-eslint

        # rust
        rust-lang.rust-analyzer
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
        "chat.commandCenter.enabled" = false;

        # Vim
        "vim.leader" = "<space>";
        "vim.normalModeKeyBindingsNonRecursive" = [
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
