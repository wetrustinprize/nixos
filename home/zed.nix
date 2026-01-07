{ pkgs, lib, ... }: {
  services.gnome-keyring.enable = true;

  home.packages = with pkgs; [
    nixd # nix language server
    alejandra # nix formatting
  ];

  home.sessionVariables = {
    EDITOR = lib.mkForce "zeditor --wait";
  };

  programs.zed-editor = {
    enable = true;
    extraPackages = with pkgs; [
      nil
    ];
    extensions = [
      # apparence
      "nord"

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
      minimap = {
        show = "auto";
      };
      icon_theme = "Zed (Default)";
      vim_mode = true;
      format_on_save = "off";
      autosave = "on_window_change";
      relative_line_numbers = "enabled";
      wrap_guides = [120];
      soft_wrap = "editor_width";
      project_panel.dock = "right";
      git_panel.dock = "right";
      collaboration_panel.dock = "right";
      outline_panel.dock = "right";
      terminal.dock = "bottom";
      disable_ai = true;
      diagnostics = {
        button = true;
        inline.enabled = true;
      };
      inlay_hints = {
        enabled = true;
        show_value_hints = true;
        show_type_hints = false;
        show_parameter_hints = true;
        show_other_hints = true;
        show_background = false;
      };

      # nix language settings
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
