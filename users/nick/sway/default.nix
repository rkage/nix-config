{ config, lib, nixosConfig, pkgs, ... }:

{
  imports = [
    ./waybar.nix
    ./wofi.nix
  ];

  wayland.windowManager.sway = 
  let
    bgdark    = "#2e3440";
    bglight   = "#4c566a";
    fgdark    = "#d8dee9";
    fglight   = "#eceff4";
    accent    = "#5e81ac";
    indicator = "#81a1c1";
    urgent    = "#bf617a";
  in {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "${pkgs.wezterm}/bin/wezterm";
      window = {
        titlebar = false;
        border = 2;
      };
      gaps = {
        inner = 10;
        outer = 0;
      };
      fonts = {
        names = [ "Inter" ];
        size = 11.0;
      };
      colors.background      = "#1e2128";
      colors.focused         = { border = accent;  background = bgdark; text = fglight; indicator = indicator; childBorder = accent; };
      colors.focusedInactive = { border = bglight; background = bgdark; text = fgdark;  indicator = indicator; childBorder = bglight; };
      colors.unfocused       = { border = bgdark;  background = bgdark; text = fgdark;  indicator = indicator; childBorder = bgdark; };
      colors.urgent          = { border = urgent;  background = bgdark; text = fglight; indicator = indicator; childBorder = urgent; };
      colors.placeholder     = { border = bgdark;  background = bgdark; text = fglight; indicator = indicator; childBorder = bgdark; };
      input = {
        "*" = {
          repeat_delay = "250";
          repeat_rate = "35";
        };
      };
      output = {
        "Virtual-1" = {
          bg = "$HOME/Pictures/wallpapers/rick-nord-left.png fill";
          resolution = "1920x1080";
          position = "0,0";
        };
      };
      bars = [];
      assigns = {
        "4" = [
          { class = "^Chromium-browser$"; }
          { class = "^Firefox$"; }
        ];
      };
    };
  };

  services.clipman = {
    enable = true;
  };

  services.gnome-keyring = {
    enable = true;
  };

  home.sessionVariables = {
    # NIXOS_OZONE_WL = 1;
    WRL_NO_HARDWARE_CURSORS = 1;
  };

  home.packages = with pkgs; [
    wdisplays
    wl-clipboard
    wlr-randr
  ];
}
