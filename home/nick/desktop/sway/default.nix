{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../shared
    ../shared/wayland-wm
    ./assigns.nix
    ./keybinds.nix
  ];

  xdg.mimeApps.enable = true;

  wayland.windowManager.sway = let
    bgdark = "#2e3440";
    bglight = "#4c566a";
    fgdark = "#d8dee9";
    fglight = "#eceff4";
    accent = "#5e81ac";
    indicator = "#81a1c1";
    urgent = "#bf617a";
  in {
    enable = true;
    checkConfig = false;
    systemd = {
      enable = true;
      xdgAutostart = true;
    };
    config = {
      terminal = lib.getExe pkgs.wezterm;
      menu = lib.getExe pkgs.wofi;
      window = {
        titlebar = false;
        border = 2;
        commands = [
          {
            command = "floating enable, resize set 1200px 800px";
            criteria.class = "^1Password$";
          }
        ];
      };
      focus = {followMouse = false;};
      gaps = {
        inner = 10;
        outer = 0;
      };
      fonts = {
        names = ["Inter"];
        size = 11.0;
      };
      colors.background = "#1e2128";
      colors.focused = {
        border = accent;
        background = bgdark;
        text = fglight;
        indicator = indicator;
        childBorder = accent;
      };
      colors.focusedInactive = {
        border = bglight;
        background = bgdark;
        text = fgdark;
        indicator = indicator;
        childBorder = bglight;
      };
      colors.unfocused = {
        border = bgdark;
        background = bgdark;
        text = fgdark;
        indicator = indicator;
        childBorder = bgdark;
      };
      colors.urgent = {
        border = urgent;
        background = bgdark;
        text = fglight;
        indicator = indicator;
        childBorder = urgent;
      };
      colors.placeholder = {
        border = bgdark;
        background = bgdark;
        text = fglight;
        indicator = indicator;
        childBorder = bgdark;
      };
      input = {
        "type:pointer" = {accel_profile = "flat";};
        "type:keyboard" = {
          repeat_delay = "250";
          repeat_rate = "35";
        };
      };
      output = {
        "HDMI-A-1" = {
          bg = "${config.wallpaperLeft} fill";
          resolution = "1920x1080";
        };
        "HDMI-A-2" = {
          bg = "${config.wallpaperRight} fill";
          resolution = "1920x1080";
        };
      };
      bars = [];
    };
  };
}
