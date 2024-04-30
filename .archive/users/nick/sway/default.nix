{
  config,
  lib,
  nixosConfig,
  pkgs,
  super,
  ...
}: {
  imports = [
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    wdisplays
    wl-clipboard
    wlr-randr
  ];

  wayland.windowManager.sway = let
    wofi = "${pkgs.wofi}/bin/wofi";
    menu = "${wofi} --show drun";

    bgdark = "#2e3440";
    bglight = "#4c566a";
    fgdark = "#d8dee9";
    fglight = "#eceff4";
    accent = "#5e81ac";
    indicator = "#81a1c1";
    urgent = "#bf617a";
    # Modes
    powerManagementMode = " : System [e]xit, [R]eboot, [S]hutdown";
    resizeMode = "󰩨 : (h) (j) (k) (l)";
    displayLayoutMode = " : (h) (j) (k) (l) [a]uto, [d]uplicate, [m]irror, [s]econd-only, primary-[o]nly";
    modifier = "Mod4";

    # Helpers
    mapDirection = {
      prefixKey ? null,
      leftCmd,
      downCmd,
      upCmd,
      rightCmd,
    }:
      with lib.strings; {
        # Arrow keys
        "${optionalString (prefixKey != null) "${prefixKey}+"}Left" = leftCmd;
        "${optionalString (prefixKey != null) "${prefixKey}+"}Down" = downCmd;
        "${optionalString (prefixKey != null) "${prefixKey}+"}Up" = upCmd;
        "${optionalString (prefixKey != null) "${prefixKey}+"}Right" = rightCmd;
        # Vi-like keys
        "${optionalString (prefixKey != null) "${prefixKey}+"}h" = leftCmd;
        "${optionalString (prefixKey != null) "${prefixKey}+"}j" = downCmd;
        "${optionalString (prefixKey != null) "${prefixKey}+"}k" = upCmd;
        "${optionalString (prefixKey != null) "${prefixKey}+"}l" = rightCmd;
      };
  in {
    enable = true;
    wrapperFeatures.gtk = true;
    config = {
      modifier = "${modifier}";
      terminal = "${pkgs.wezterm}/bin/wezterm";
      keybindings = lib.mkOptionDefault {
        "${modifier}+d" = "exec ${menu}";

        "${modifier}+r" = ''mode "${resizeMode}"'';
        "${modifier}+Escape" = ''mode "${powerManagementMode}"'';

        "${modifier}+p" = ''mode "${displayLayoutMode}"'';

        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+r" = "restart";
        "${modifier}+Shift+q" = "kill";
        "${modifier}+Shift+e" = "exit";
      };
      modes = let
        exitMode = {
          "Escape" = "mode default";
          "Return" = "mode default";
        };
      in {
        ${resizeMode} =
          (mapDirection {
            upCmd = "resize shrink height 10px or 10ppt";
            downCmd = "resize grow height 10px or 10ppt";
            leftCmd = "resize shrink width 10px or 10ppt";
            rightCmd = "resize grow width 10px or 10ppt";
          })
          // exitMode;
        ${powerManagementMode} =
          {
            e = "mode default, exec loginctl terminate-session $XDG_SESSION_ID";
            "Shift+r" = "mode default, exec systemctl reboot";
            "Shift+s" = "mode default, exec systemctl poweroff";
          }
          // exitMode;
      };
      window = {
        titlebar = false;
        border = 2;
        commands = [
          {
            command = "floating enable";
            criteria.class = "^1Password$";
          }
          {
            command = "resize set 1200px 800px";
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
        "Virtual-1" = {
          bg = "$HOME/Pictures/wallpapers/rick-nord-left.png fill";
          resolution = "1920x1080";
          position = "0,0";
          # } // lib.optionalAttrs (super ? fonts.fontconfig) {
          #   subpixel = super.fonts.fontconfig.subpixel.rgba;
        };
      };
      bars = [];
      assigns = {
        "4" = [
          {class = "^Chromium-browser$";}
          {class = "^Firefox$";}
          {app_id = "^firefox$";}
        ];
      };
    };
    extraConfig = ''
      exec configure-gtk
      exec dbus-sway-environment
    '';
    systemd = {
      enable = true;
      xdgAutostart = true;
    };
  };

  programs.wofi = {
    enable = true;
    style = builtins.readFile ./wofi-style.css;
  };

  home.pointerCursor = {
    package = pkgs.nordzy-cursor-theme;
    name = "Nordzy-cursors";
    size = 24;
    x11.enable = true;
    gtk.enable = true;
  };

  services.clipman = {
    enable = true;
  };

  services.gnome-keyring = {
    enable = true;
  };

  home.sessionVariables = {
    # NIXOS_OZONE_WL = 1;
    # WRL_NO_HARDWARE_CURSORS = 1;
  };
}
