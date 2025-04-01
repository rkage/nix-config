{ lib, pkgs, ... }:
let
  mainMod = "SUPER";
  altMod = "Alt_L";
  defaultApp = type: "${lib.getExe pkgs.handlr-regex} launch ${type}";
in
{
  wayland.windowManager.hyprland.settings = {
    bind =
      let
        workspaces = [
          "0"
          "1"
          "2"
          "3"
          "4"
          "5"
          "6"
          "7"
          "8"
          "9"
          "0"
        ];
        directions = rec {
          left = "l";
          right = "r";
          up = "u";
          down = "d";
          h = left;
          l = right;
          k = up;
          j = down;
        };
      in
      [
        "${altMod}, code:36, exec, ${defaultApp "x-scheme-handler/terminal"}"
        "${altMod}, code:51, exec, ${lib.getExe pkgs._1password-gui} --quick-access"
        "${altMod}, d, exec, ${lib.getExe pkgs.wofi} --normal-window"

        "${mainMod}, C, killactive,"
        "${mainMod}, V, togglefloating,"
        "${mainMod}, P, pseudo,"
        "${mainMod}, J, togglesplit,"

        "${mainMod}, S, togglespecialworkspace, magic"
        "${mainMod} SHIFT, S, movetoworkspace, special:magic"

        "${mainMod}, mouse_down, workspace, e+1"
        "${mainMod}, mouse_up, workspace, e-1"

        "${mainMod}, equal, splitratio, 0.25"
        "${mainMod}, minus, splitratio, -0.25"
        "${mainMod} SHIFT, equal, splitratio, 0.3333333"
        "${mainMod} SHIFT, minus, splitratio, -0.3333333"
      ]
      ++ (lib.mapAttrsToList (key: direction: "${mainMod}, ${key}, movefocus, ${direction}") directions)
      ++ (lib.mapAttrsToList (
        key: direction: "${mainMod} SHIFT, ${key}, swapwindow, ${direction}"
      ) directions)
      ++ (lib.mapAttrsToList (
        key: direction: "${mainMod} CONTROL, ${key}, movewindow, ${direction}"
      ) directions)
      ++ (map (n: "${altMod}, ${n}, workspace, ${n}") workspaces)
      ++ (map (n: "${altMod} SHIFT, ${n}, movetoworkspacesilent, ${n}") workspaces);

    bindm = [
      "${mainMod}, mouse:272, movewindow"
      "${mainMod}, mouse:273, resizewindow"
    ];

    bindl = [
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];

    bindel = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ", XF86MonBrightnessUp, exec, brightnessctl s 10%+"
      ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
    ];
  };

  wayland.windowManager.hyprland.extraConfig =
    let
      powerManagementSubmap = " : System [e]xit, [R]eboot, [S]hutdown";
    in
    ''
      bind=${mainMod}, M, submap, ${powerManagementSubmap}
      submap=${powerManagementSubmap}
      bind=, e, exec, uwsm stop
      bind=SHIFT, r, exec, systemctl reboot
      bind=SHIFT, s, exec, systemctl poweroff
      bind=, escape, submap, reset
      submap=reset
    '';
}
