{...}: {
  flake.nixosModules.zed-editor = {...}: {
    services.gnome-keyring.enable = true;
  };

  flake.homeModules.zed-editor = {pkgs, ...}: {
    home.packages = with pkgs; [
      nixd # nix lsp
      alejandra # nix formatter
    ];

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
        "scss"
        "csharp"
        "toml"
        "git-firefly"
      ];

      userSettings = {
        auto_update = false;
        vim_mode = true;
        format_on_save = "off";
        autosave = "on_window_change";
        relative_line_numbers = "enabled";
        wrap_guides = [120];
        soft_wrap = "editor_width";
        minimap = {
          thumb_border = "left_open";
          display_in = "active_editor";
          show = "auto";
        };
        diagnostics = {
          button = true;
          inline.enabled = true;
        };
        hover_popover_delay = 50;
        use_system_path_prompts = false;
        use_system_prompts = false;
        calls.mute_on_join = true;
        git.inline_blake.show_commit_summary = false;
        show_whitespaces = "selection";
        edit_predictions.mode = "eager";
        git_panel.button = false;
        inlay_hints = {
          enabled = true;
          show_value_hints = true;
          show_type_hints = false;
          show_parameter_hints = true;
          show_other_hints = true;
          show_background = false;
        };
        disable_ai = false;
        features = {
          edit_prediction_provider = "zed";
        };
        agent = {
          play_sound_when_agent_done = true;
          always_allow_tool_actions = false;
          default_profile = "write";
          dock = "left";
        };
        icon_theme = "Zed (Default)";
        project_panel.dock = "right";
        git_panel.dock = "right";
        collaboration_panel.dock = "right";
        outline_panel.dock = "right";
        terminal.dock = "bottom";
        window_decorations = "server";
        toolbar = {
          code_actions = false;
          breadcrumbs = true;
        };
        title_bar = {
          show_user_picture = false;
          show_sign_in = false;
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

      userKeymaps = [
        {
          context = "(Editor && edit_prediction)";
          bindings = {
            tab = null;
          };
        }
      ];

      userTasks = [];
    };
  };
}
