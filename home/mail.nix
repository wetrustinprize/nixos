{ config, ... }:
{
  sops.secrets."email-password".path = "%r/email-password";

  accounts = {
    email.accounts."me" = {
      imap = {
        host = "imap.fastmail.com";
        port = 993;
      };

      address = "me@wetrustinprize.com";
      userName = "me@wetrustinprize.com";
      realName = "Peterson \"Prize\" Adami Candido";
      passwordCommand = "cat ${config.sops.secrets."email-password".path}";
      primary = true;

      thunderbird.enable = true;
    };

    calendar.accounts."me" = {
      remote = {
        type = "caldav";
        url = "https://caldav.fastmail.com/";
        userName = "me@wetrustinprize.com";
        passwordCommand = "cat ${config.sops.secrets."email-password".path}";
      };

      primary = true;
      thunderbird.enable = true;
    };

    contact.accounts."me" = {
      remote = {
        type = "carddav";
        url = "https://carddav.fastmail.com/";
        userName = "me@wetrustinprize.com";
        passwordCommand = "cat ${config.sops.secrets."email-password".path}";
      };

      thunderbird.enable = true;
    };
  };

  programs.thunderbird = {
    profiles."wetrustinprize" = {
      isDefault = true;
    };
    enable = true;
  };
}
