{pkgs, ...}: {
  imports = [
    ./font.nix
    ./gtk.nix
    ./zed.nix
    ./1password.nix
    ./brave.nix
  ];

  home.packages = with pkgs; [
    libnotify
    handlr-regex
    legcord
  ];

  xdg.portal.enable = true;
}
