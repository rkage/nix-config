{ lib, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "${lib.getExe pkgs.ghostty} --gtk-single-instance=true --quit-after-last-window-closed=false --initial-window=false"
    ];
  };
}
