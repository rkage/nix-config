{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./gtk.nix
    ./fonts.nix
    ./firefox.nix
    ./wezterm.nix
  ];

  # Also sets org.freedesktop.appearance color-scheme
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  xdg.portal.enable = true;
}
