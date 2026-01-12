{ pkgs, lib, ... }: {
  services.gnome-keyring.enable = true;

  home.packages = with pkgs; [
    nixd # nix language server
    alejandra # nix formatting

    omnisharp-roslyn # csharp lsp
    dotnet-sdk_10 # dotnet sdk
  ];

  programs.niri.settings.environment = {
    EDITOR = lib.mkForce "zeditor --wait";
    DOTNET_ROOT = "${pkgs.dotnet-sdk_10}/share/dotnet";
  };

  programs.zed-editor = {
    enable = true;
    extensions = [
      # behaviour
      "wakatime"

      # lanaguages
      "editorconfig"
      "dockerfile"
      "html"
      "nix"
      "gdscript"
      "lua"
      "rainbow-csv"
      "hyprlang"
      "scss"
      "csharp"
      "java"
      "gleam"
      "toml"
      "git-firefly"
    ];
    userSettings = {
      auto_update = false; # nix must handle it

      # no-ai
      disable_ai = true;

      # behaviour
      vim_mode = true;
      format_on_save = "off";
      autosave = "on_window_change";
      relative_line_numbers = "enabled";
      wrap_guides = [120];
      soft_wrap = "editor_width";
      minimap.show = "auto";
      diagnostics.inline.enabled = true;
      hover_popover_delay = 50;
      use_system_path_prompts = false;
      use_system_prompts = false;
      calls.mute_on_join = true;
      inlay_hints = {
        enabled = true;
        show_value_hints = true;
        show_type_hints = false;
        show_parameter_hints = true;
        show_other_hints = true;
        show_background = false;
      };

      # apparence
      icon_theme = "Zed (Default)";
      project_panel.dock = "right";
      git_panel.dock = "right";
      collaboration_panel.dock = "right";
      outline_panel.dock = "right";
      terminal.dock = "bottom";
      window_decorations = "server";

      title_bar = {
        show_user_picture = false;
        show_sign_in = false;
      };

      lsp = {
        omnisharp = {
          binary = {
            path = "${pkgs.omnisharp-roslyn}/bin/OmniSharp";
            arguments = ["-lsp"];
          };
        };
      };

      languages = {
        Nix = {
          language_servers = ["nixd" "!nil"];
          formatter.external = {
            command = "alejandra";
            arguments = ["--quiet" "--"];
          };
        };
      };
    };
    userKeymaps = [];
    userTasks = [];
  };
}
