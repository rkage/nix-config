{
  config,
  lib,
  pkgs,
  ...
}: {
  xsession.windowManager.i3 = let
    modifier = "Mod4";
    menu = "${pkgs.rofi}/bin/rofi -show drun";
    terminal = "${pkgs.wezterm}/bin/wezterm";

    bgdark = "#2e3440";
    bglight = "#4c566a";
    fgdark = "#d8dee9";
    fglight = "#eceff4";
    accent = "#5e81ac";
    indicator = "#81a1c1";
    urgent = "#bf617a";

    # Modes Configurations
    resizeMode = "󰩨 : (h) (j) (k) (l)";
    powerManagementMode = " : System [e]xit, [R]eboot, [S]hutdown";

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
    config = {
      modifier = "${modifier}";
      terminal = "${terminal}";
      menu = "${menu}";

      keybindings = lib.mkOptionDefault {
        "${modifier}+r" = ''mode "${resizeMode}"'';
        "${modifier}+Escape" = ''mode "${powerManagementMode}"'';
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
            command = "floating enable, resize set 1200px 800px";
            criteria.class = "^1Password$";
          }
        ];
      };

      colors = {
        background = "#1e2128";
        focused = {
          border = accent;
          background = bgdark;
          text = fglight;
          indicator = indicator;
          childBorder = accent;
        };
        focusedInactive = {
          border = bglight;
          background = bgdark;
          text = fgdark;
          indicator = indicator;
          childBorder = bglight;
        };
        unfocused = {
          border = bgdark;
          background = bgdark;
          text = fgdark;
          indicator = indicator;
          childBorder = bgdark;
        };
        urgent = {
          border = urgent;
          background = bgdark;
          text = fglight;
          indicator = indicator;
          childBorder = urgent;
        };
        placeholder = {
          border = bgdark;
          background = bgdark;
          text = fglight;
          indicator = indicator;
          childBorder = bgdark;
        };
      };

      gaps = {
        inner = 6;
        outer = 0;
      };

      fonts = {
        names = ["Inter"];
        size = 9.0;
      };
      assigns = {
        "4" = [
          {class = "^Chromium-browser$";}
        ];
      };
    };
  };

  services.polybar = {
    enable = true;
    script = "polybar bar &";
  };

  programs.rofi = {
    enable = true;

    font = "Noto Sans 12";
    terminal = "${pkgs.wezterm}/bin/wezterm";
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        foreground = mkLiteral "#d8dee9";
        normal-foreground = mkLiteral "@foreground";
        background = mkLiteral "#2e3440";
        background-color = mkLiteral "rgba ( 0, 0 , 0, 0 % )";
        border-color = mkLiteral "#5e81ac";
      };
      window = {
        border = mkLiteral "1px";
        background-color = mkLiteral "@background";
      };
      scrollbar = {
        width = mkLiteral "4px";
        border = mkLiteral "0";
        handle-color = mkLiteral "@normal-foreground";
        handle-width = mkLiteral "8px";
        padding = mkLiteral "0";
      };
      inputbar = {
        margin = mkLiteral "5px";
        background-color = mkLiteral "#3b4252";
        children = map mkLiteral ["entry"];
      };
      entry = {
        padding = mkLiteral "2px";
        placeholder = "Search";
        placeholder-color = mkLiteral "#2e3440";
        vertical-align = mkLiteral "0.5";
      };
      listview = {
        lines = 10;
        columns = 1;
        fixed-height = false;
        scrollbar = true;
        margin = mkLiteral "0 4px 4px 4px";
      };
      element = {
        padding = mkLiteral "4px";
      };
      element-text = {
        text-color = mkLiteral "@normal-foreground";
      };
      "element normal active" = {
        background-color = mkLiteral "#0000ff";
      };
      "element selected normal" = {
        background-color = mkLiteral "#3b4252";
      };
    };
  };
}
