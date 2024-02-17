{ config, ... }: {
  programs.rofi = {
    enable = true;
    theme = let inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "configuration" = {
        "font" = "JetBrainsMonoNerdFont 12";
        "width" = 30;
        "line-margin" = 10;
        "lines" = 6;
        "columns" = 2;

        "display-ssh" = "";
        "display-run" = "";
        "display-drun" = "";
        "display-window" = "";
        "display-combi" = "";
        "show-icons" = true;
      };

      "*" = {
        "nord0" = mkLiteral "#2e3440";
        "nord1" = mkLiteral "#3b4252";
        "nord2" = mkLiteral "#434c5e";
        "nord3" = mkLiteral "#4c566a";

        "nord4" = mkLiteral "#d8dee9";
        "nord5" = mkLiteral "#e5e9f0";
        "nord6" = mkLiteral "#eceff4";

        "nord7" = mkLiteral "#8fbcbb";
        "nord8" = mkLiteral "#88c0d0";
        "nord9" = mkLiteral "#81a1c1";
        "nord10" = mkLiteral "#5e81ac";
        "nord11" = mkLiteral "#bf616a";

        "nord12" = mkLiteral "#d08770";
        "nord13" = mkLiteral "#ebcb8b";
        "nord14" = mkLiteral "#a3be8c";
        "nord15" = mkLiteral "#b48ead";

        "foreground" = mkLiteral "@nord9";
        "backlight" = "#ccffeedd";
        "background-color" = mkLiteral "transparent";

        "highlight" = mkLiteral "underline bold #eceff4";

        "transparent" = mkLiteral "rgba(46,52,64,0)";
      };

      "window" = {
        "location" = mkLiteral "center";
        "anchor" = mkLiteral "center";
        "transparency" = "screenshot";
        "padding" = mkLiteral "10px";
        "border" = mkLiteral "0px";
        "border-radius" = mkLiteral "6px";
        "background-color" = mkLiteral "@transparent";
        "spacing" = 0;
        "children" = map mkLiteral [ "mainbox" ];
        "orientation" = mkLiteral "horizontal";
      };

      "mainbox" = {
        "spacing" = 0;
        "children" = map mkLiteral [ "inputbar" "message" "listview" ];
      };

      "message" = {
        "color" = mkLiteral "@nord0";
        "padding" = mkLiteral "5";
        "border-color" = mkLiteral "@foreground";
        "border" = mkLiteral "0px 2px 2px 2px";
        "background-color" = mkLiteral "@nord7";
      };

      "inputbar" = {
        "color" = mkLiteral "@nord6";
        "padding" = mkLiteral "11px";
        "background-color" = mkLiteral "#3b4252";
        "border" = mkLiteral "1px";
        "border-radius" = mkLiteral "6px 6px 0px 0px";
        "border-color" = mkLiteral "@nord10";
      };

      "entry" = {
        "text-font" = mkLiteral "inherit";
        "text-color" = mkLiteral "inherit";
      };

      "prompt" = {
        "margin" = mkLiteral "0px 0.3em 0em 0em";
        "color" = mkLiteral "@nord6";
      };

      "listview" = {
        "padding" = mkLiteral "8px";
        "border-radius" = mkLiteral "0px 0px 6px 6px";
        "border-color" = mkLiteral "@nord10";
        "border" = mkLiteral "0px 1px 1px 1px";
        "background-color" = mkLiteral "rgba(46,52,64,0.9)";
        "dynamic" = false;
      };

      "element-text" = { "text-color" = mkLiteral "@nord4"; };

      "element" = {
        "padding" = mkLiteral "3px";
        "vertical-align" = mkLiteral "0.5";
        "border-radius" = mkLiteral "4px";
        "background-color" = mkLiteral "transparent";
        "color" = mkLiteral "@foreground";
        "text-color" = mkLiteral "rgb(216, 222, 233)";
      };

      "element selected.normal" = {
        "background-color" = mkLiteral "@nord7";
        "text-color" = mkLiteral "#2e3440";
      };

      "button" = {
        "padding" = mkLiteral "6px";
        "color" = mkLiteral "@foreground";
        "horizontal-align" = mkLiteral "0.5";
        "border" = mkLiteral "2px 0px 2px 2px";
        "border-radius" = mkLiteral "4px 0px 0px 4px";
        "border-color" = mkLiteral "@foreground";
      };

      "button selected normal" = {
        "border" = mkLiteral "2px 0px 2px 2px";
        "border-color" = mkLiteral "@foreground";
      };
    };
  };
}
