{ inputs, ... }:
let
  mkExtensionSettings = builtins.mapAttrs (
    _: pluginId: {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
      installation_mode = "force_installed";
    }
  );
  mkLockedAttrs = builtins.mapAttrs (
    _: value: {
      Value = value;
      Status = "locked";
    }
  );
in
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {
    enable = true;
    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      Preferences = mkLockedAttrs {
        "browser.startup.homepage" = "https://kagi.com/";
        "zen.welcome-screen.seen" = true;
      };
      ExtensionSettings = mkExtensionSettings {
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = "bitwarden";
        "sponsorBlocker@ajay.app" = "sponsorBlocker";
        "firefox-extension@steamdb.info" = "steamdb";
        "{2662ff67-b302-4363-95f3-b050218bd72c}" = "untrapyt";
        "{458160b9-32eb-4f4c-87d1-89ad3bdeb9dc}" = "ytantitranslate";
        "clipper@obsidian.md" = "clipper";
      };
    };
  };
}
