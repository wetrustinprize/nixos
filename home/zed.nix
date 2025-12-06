{ pkgs, ... }: {
  services.gnome-keyring.enable = true;

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
      relative_line_numbers = true;
      wrap_guides = [80 120];
      agent = {
        play_sound_when_agent_done = true;
        dock = "left";
      };
      project_panel = {
        dock = "right";
      };
      git_panel = {
        dock = "right";
      };
      collaboration_panel = {
        dock = "right";
      };
      outline_panel = {
        dock = "right";
      };
      terminal = {
        dock = "right";
      };
      diagnostics = {
        button = false;
      };
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
