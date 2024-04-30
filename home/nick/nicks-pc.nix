{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./common.nix

    ./desktop/sway
  ];

  # wallpaper = lib.mkDefault pkgs.wallpapers.rick-nord-wallpaper;

}
