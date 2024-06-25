{lib, ...}: let
  inherit (lib) types mkOption;
in {
  options.wallpaper = mkOption {
    type = types.nullOr types.path;
    default = null;
    description = ''
      Wallpaper path
    '';
  };
  options.wallpaperLeft = mkOption {
    type = types.nullOr types.path;
    default = null;
    description = ''
      Left Monitor Wallpaper path
    '';
  };
  options.wallpaperRight = mkOption {
    type = types.nullOr types.path;
    default = null;
    description = ''
      Right Monitor Wallpaper path
    '';
  };
}
