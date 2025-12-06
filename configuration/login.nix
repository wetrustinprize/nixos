{ pkgs, ... } :
{
  environment.systemPackages = with pkgs; [
    tuigreet
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = pkgs.lib.mkForce "${pkgs.tuigreet}/bin/tuigreet --remember --time --time-format '%I:%M %p | %a • %h | %F'";
      };
    };
  };
}
