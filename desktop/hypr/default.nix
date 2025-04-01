{ pkgs, ... }:
{
  imports = [
    ../common
    ../common/wayland-wm

    ./hyprland/binds.nix
    ./hyprland/decorations.nix
    ./hyprland/rules.nix
    ./hyprland/execs.nix
    ./hyprland/env.nix

    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];

  xdg.portal = {
    config.hyprland = {
      default = [
        "wlr"
        "gtk"
      ];
    };
  };

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    monitor = ",preferred,auto,1.5";
    xwayland = {
      force_zero_scaling = true;
    };
    input = {
      kb_layout = "us";
      repeat_delay = 250;
      repeat_rate = 35;
    };
    source = "~/.config/hypr/colors.conf";
    general = {
      gaps_in = 2;
      gaps_out = 10;
      border_size = 2;
      allow_tearing = false;
      layout = "dwindle";
    };
    dwindle = {
      pseudotile = true;
      preserve_split = true;
      smart_split = false;
      smart_resizing = false;
      split_width_multiplier = 1.35;
    };
    gestures = {
      workspace_swipe = false;
    };
    misc = {
      disable_hyprland_logo = true;
      focus_on_activate = true;
    };
  };

  home.packages = with pkgs; [
    hyprpolkitagent
  ];
}
