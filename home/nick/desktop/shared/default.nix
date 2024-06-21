{pkgs, ...}: {
  imports = [
    ./gtk.nix
    ./fonts.nix
    ./firefox.nix
    ./discord.nix
    ./slack.nix
    ./pavucontrol.nix
    ./wezterm.nix
  ];

  home.packages = [pkgs.libnotify];

  # Also sets org.freedesktop.appearance color-scheme
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  xdg.portal.enable = true;
}
