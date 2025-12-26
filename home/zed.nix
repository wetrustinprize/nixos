{ pkgs, ... }: {
  sops.secrets."ai-keys/anthropic".path = "%r/anthropic-key";

  services.gnome-keyring.enable = true;

  home.packages = with pkgs; [
    nixd # nix language server
    nil # nix language server
  ];

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
      agent = {
        default_model = {
          provider = "anthropic";
          model = "claude-sonnet-4-5-latest";
        };
        play_sound_when_agent_done = true;
        dock = "left";
      };
      project_panel.dock = "right";
      git_panel.dock = "right";
      collaboration_panel.dock = "right";
      outline_panel.dock = "right";
      terminal.dock = "bottom";
      diagnostics.button = false;
      lsp = {
        nil = {
          settings = {
            autoArchive = true;
          };
        };
      };
    };
    userKeymaps = [];
    userTasks = [];
  };
}
