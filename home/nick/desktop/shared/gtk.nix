{
  config,
  pkgs,
  lib,
  ...
}: {
  gtk = {
    enable = true;
    font = {
      name = "Inter";
      size = 11;
    };
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
  };

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
}
