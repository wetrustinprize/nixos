{
  lib,
  config,
  ...
}: {
  options.libParts = lib.mkOption {
    type = lib.types.attrs;
    default = {};
  };

  config = {
    flake.lib = config.libParts;
  };
}
