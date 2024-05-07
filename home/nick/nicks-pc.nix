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
}
