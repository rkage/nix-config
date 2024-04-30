{pkgs ? import <nixpkgs> {}}: let
  inherit (pkgs) lib;
in rec {
  wallpapers = import ./wallpapers {inherit pkgs;};
  # allWallpapers = pkgs.linkFarmFromDrvs "wallpapers" (lib.attrValues wallpapers);
}
