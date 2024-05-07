{
  pkgs,
  lib,
  config,
  ...
}: let
  homeConfigs = config.home-manager.users;
  homeSharePaths = lib.mapAttrsToList (_: v: "${v.home.path}/share") homeConfigs;
  nickConfig = homeConfigs.nick;
  wallpaper = nickConfig.wallpaper;

  vars = ''XDG_DATA_DIRS=$XDG_DATA_DIRS:${lib.concatStringsSep ":" homeSharePaths} GTK_USE_PORTAL=0'';

  sway-greetd = command: "${lib.getExe pkgs.sway} --unsupported-gpu --config ${pkgs.writeText "greetd-config" ''
    output * bg #000000 solid_color
    xwayland disable
    exec '${vars} ${command}; ${pkgs.sway}/bin/swaymsg exit'
  ''}";
in {
  users.extraUsers.greeter = {
    packages = [
      pkgs.nordic
    ];
    home = "/tmp/greeter-home";
    createHome = true;
  };

  programs.regreet = {
    enable = true;
    settings = {
      GTK = {
        application_prefer_dark_theme = true;
        theme_name = "Nordic-darker";
      };
      background = {
        path = builtins.fetchurl {
          url = "https://i.imgur.com/g9UFBTk.jpg";
          sha256 = "0xynlk05212b0bhyavc7iwabq6hxr6fla6hqkvmp464g48lgyyn8";
        };
        fit = "Cover";
      };
    };
  };

  services.greetd = {
    enable = true;
    settings.default_session.command = sway-greetd (lib.getExe config.programs.regreet.package);
  };
}
