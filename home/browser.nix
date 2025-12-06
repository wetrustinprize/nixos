{ user, ... }: {
  stylix.targets.firefox.profileNames = [ user.username ];

  programs.firefox = {
    enable = true;

    profiles.${user.username} = {
      isDefault = true;
    };
  };

  programs.chromium = {
    enable = true;
  };
}
