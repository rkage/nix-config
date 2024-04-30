{ pkgs, ... }: {
  imports = [
    ./gammastep.nix
    ./swayidle.nix
    ./swaylock.nix
    ./wofi.nix
  ];

  home.packages = with pkgs; [
    wdisplays
    wf-recorder
    wl-clipboard
    wlr-randr
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    LIBSEAT_BACKEND = "logind";
  };

  home.pointerCursor = {
    package = pkgs.nordzy-cursor-theme;
    name = "Nordzy-cursors";
    size = 24;
    gtk.enable = true;
  };

  xdg.mimeApps.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-wlr];
}
