{ config, lib, pkgs, ... }:

let
  indexCache = {
    linux = builtins.fetchurl {
      url = "https://github.com/nix-community/nix-index-database/releases/download/2023-11-26-030655/index-aarch64-linux";
      sha256 = "1bdbap9y4s29p2wl2zim8cjkcavzrdsf97d6rkxxazys9an76djg";
    };
  }.${pkgs.stdenv.hostPlatform.parsed.kernel.name};
in
{
  home.file.".cache/nix-index/files".source = indexCache;
  programs.nix-index.enable = true;
}
