{
  pkgs,
  system,
  inputs,
  username,
  ...
}:
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
  home.packages = with pkgs; [
    nixd
    nixfmt-rfc-style
  ];

  nixpkgs.overlays = [
    inputs.nix-vscode-extensions.overlays.default
  ];

  # FIXME: Look after why code is so bad at wayland
  # this wasn't an issue in the past
  xdg.desktopEntries."code" = {
    name = "Visual Studio Code";
    genericName = "Text Editor";
    exec = "code --ozone-platform=x11";
  };

  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    
    profiles.default = {
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      userSettings = {
        "window.newWindowProfile" = "${username}";
      };
    };

    profiles.${username} = {
      extensions =
        (with pkgs.nix-vscode-extensions; [
          # theme
          vscode-marketplace.arcticicestudio.nord-visual-studio-code
          vscode-marketplace.miguelsolorio.fluent-icons
          vscode-marketplace.miguelsolorio.symbols

          # cosmetics
          vscode-marketplace.icrawl.discord-vscode

          # behaviour
          vscode-marketplace.vscodevim.vim
          vscode-marketplace.eamodio.gitlens
          vscode-marketplace.wakatime.vscode-wakatime
          vscode-marketplace.naumovs.color-highlight
          vscode-marketplace.gruntfuggly.todo-tree
          vscode-marketplace.jgclark.vscode-todo-highlight
          vscode-marketplace.oderwat.indent-rainbow
          vscode-marketplace.ms-vsliveshare.vsliveshare
          vscode-marketplace.aaron-bond.better-comments
          vscode-marketplace.editorconfig.editorconfig
          vscode-marketplace.praveencrony.total-lines
          vscode-marketplace.rhalaly.scope-to-this
          vscode-marketplace.christian-kohler.path-intellisense
          vscode-marketplace.usernamehw.errorlens
          vscode-marketplace.hbenl.vscode-test-explorer
          vscode-marketplace.ms-vscode.test-adapter-converter

          # spell checking
          vscode-marketplace.streetsidesoftware.code-spell-checker
          vscode-marketplace.streetsidesoftware.code-spell-checker-portuguese-brazilian

          # toml
          vscode-marketplace.tamasfe.even-better-toml

          # dotenv
          vscode-marketplace.mikestead.dotenv

          # nix
          vscode-marketplace.bbenoist.nix

          # html/css
          vscode-marketplace.formulahendry.auto-rename-tag

          # javascript/typescript
          vscode-marketplace.dbaeumer.vscode-eslint
          vscode-marketplace.bradlc.vscode-tailwindcss
          vscode-marketplace.quicktype.quicktype
          vscode-marketplace.yoavbls.pretty-ts-errors
          vscode-marketplace.wallabyjs.console-ninja

          # react
          vscode-marketplace.styled-components.vscode-styled-components

          # vue
          vscode-marketplace.vue.volar

          # rust
          vscode-marketplace.rust-lang.rust-analyzer

          # gdscript
          vscode-marketplace.geequlim.godot-tools

          # nix
          vscode-marketplace.jnoortheen.nix-ide
        ])
        ++ [ forkedNixpkgs.vscode-extensions.ms-vscode-remote.remote-ssh ];

      userSettings = {
        "workbench.iconTheme" = "symbols";
        "workbench.productIconTheme" = "fluent-icons";
        "workbench.startupEditor" = "none";
        "workbench.sideBar.location" = "right";
        "workbench.navigationControl.enabled" = false;
        "workbench.layoutControl.enabled" = false;
        "workbench.colorTheme" = "Nord";
        "window.customTitleBarVisibility" = "never";
        "window.commandCenter" = false;
        "update.mode" = "none";
        "terminal.integrated.fontLigatures.enabled" = true;
        "git.followTagsWhenSync" = true;
        "git.confirmSync" = false;
        "git.autoStash" = true;
        "git.autofetch" = "all";
        "files.autoSave" = "onWindowChange";
        "extensions.autoCheckUpdates" = false;
        "editor.wordWrap" = "on";
        "editor.suggest.showWords" = false;
        "editor.minimap.enabled" = false;
        "editor.formatOnSaveMode" = "modifications";
        "editor.formatOnSave" = true;
        "editor.fontLigatures" = true;
        "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
        "terminal.integrated.env.linux" = {};
        "chat.commandCenter.enabled" = false;

        # Spelling
        "cSpell.language" = "en,pt,pt_BR";

        # Ninja
        "console-ninja.featureSet" = "Community";

        # Typescript
        "typescript.updateImportsOnFileMove.enabled" = "always";

        # Discord
        "discord.suppressNotifications" = true;
        "discord.removeRemoteRepository" = true;
        "discord.lowerDetailsNoWorkspaceFound" = "{file_size}, {total_lines} lines";
        "discord.lowerDetailsEditing" = "{file_size}, {total_lines} lines";
        "discord.lowerDetailsDebugging" = "{file_size}, {total_lines} lines";
        "discord.detailsIdling" = "Farming WakaTime.";
        "discord.detailsEditing" = "Editing a file.";
        "discord.detailsDebugging" = "Debugging some bugs.";

        # Nix
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.formatterPath" = "nixfmt";
        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              "command" = [ "nixfmt" ];
            };
            "options" = {
              "nixos" = {
                "expr" =
                  "(builtins.getFlake \"/home/${username}/nixos/flake.nix\").nixosConfigurations.<name>.options";
              };
              "home-manager" = {
                "expr" =
                  "(builtins.getFlake \"/home/${username}/nixos/flake.nix\").nixosConfigurations.<name>.options.home-manager.users.type.getSubOptions []";
              };
            };
          };
        };

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
