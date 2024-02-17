{ pkgs, lib, ... }: {
  # currently there is no official godot4-mono package
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "vscode" "unityhub" ];

  home.packages = with pkgs; [ vscode unityhub ];
}
