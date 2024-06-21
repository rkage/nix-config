{
  lib,
  pkgs,
  config,
  ...
}: {
  wayland.windowManager.sway.config = let
    mod = "Mod1"; # Alt

    # Modes
    resizeMode = "󰩨 : (h) (j) (k) (l)";
    powerManagementMode = " : System [e]xit, [R]eboot, [S]hutdown";
    displayLayoutMode = " : (h) (j) (k) (l) [a]uto, [d]uplicate, [m]irror, [s]econd-only, primary-[o]nly";
    exitMode = {
      "Escape" = "mode default";
      "Return" = "mode default";
    };
    notify-send = lib.getExe pkgs.libnotify "notify-send";

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
    modes = {
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
    keybindings = lib.mkOptionDefault {
      "${mod}+r" = ''mode "${resizeMode}"'';
      "${mod}+Escape" = ''mode "${powerManagementMode}"'';
      "${mod}+p" = ''mode "${displayLayoutMode}"'';
    };
  };
}
