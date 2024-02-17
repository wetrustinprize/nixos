{ pkgs, config, ... }: {
  nixpkgs.config.packageOverrides = pkgs: {
    godot4-mono = import (fetchTarball
      "https://github.com/NixOS/nixpkgs/archive/e23c84699c90bb7dbe88f2cd25c950905c213590.tar.gz") {
        config = config.nixpkgs.config;
      };
  };
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "vscode" "unityhub" ];

  home.packages = with pkgs; [ vscode unityhub godot4-mono ];
}
