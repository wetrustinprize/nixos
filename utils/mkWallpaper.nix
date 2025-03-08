{ lib, pkgs, ... }:
{
  width,
  height,
  scheme,
}:
pkgs.runCommand "generated-wallpaper-${scheme.slug}.png"
  {
    nativeBuildInputs = with pkgs; [ imagemagick ];
    src = lib.fileset.toSource {
      root = ./.;
      fileset = ./logo.png;
    };
  }
  ''
    magick -size ${toString width}x${toString height} xc:"#${scheme.palette.base00}" \
    ${./logo.png} -gravity center -composite \
    $out
  ''
