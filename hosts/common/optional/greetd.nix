{
  pkgs,
  lib,
  config,
  ...
}:
let
  homeConfig = config.home-manager.users;
  # homeSharePaths = lib.mapAttrsToList (_: v: "${v.home.path}/share") homeConfig;
  # vars = ''XDG_DATA_DIRS="$XDG_DATA_DIRS:${lib.concatStringsSep ":" homeSharePaths}" GTK_USE_PORTAL=0'';

  nickHomeConfig = homeConfig.nick;

  hyprland-config = pkgs.writeText "hyprland.conf" ''
    exec-once = ${lib.getExe config.programs.regreet.package}; ${lib.getExe' pkgs.hyprland "hyprctl"} dispatch exit
    monitor=,preferred,auto,1.5
    misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
        disable_hyprland_qtutils_check = true
    }
  '';
in
{
  users.extraUsers.greeter = {
    # For caching and such
    home = "/tmp/greeter-home";
    createHome = true;
  };

  programs.regreet = {
    enable = true;
    theme = nickHomeConfig.gtk.theme;
    font = {
      name = "Inter Display";
      size = 14;
      package = pkgs.inter;
    };
    # cursorTheme = {
    #   inherit (nickHomeConfig.gtk.cursorTheme) name package;
    # };
    # settings.background = {
    #   path = nickHomeConfig.wallpaper;
    #   fit = "Cover";
    # };
  };
  services.greetd = {
    enable = true;
    settings.default_session.command = "${lib.getExe config.programs.hyprland.package} --config ${hyprland-config}";
  };
}
