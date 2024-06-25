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

  wallpaperLeft = pkgs.wallpapers.dumbest-way-possible;
  wallpaperRight = pkgs.wallpapers.rick-nord-wallpaper;
}
