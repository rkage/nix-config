{ config, ... }:
{
  wayland.windowManager.hyprland.settings = {
    env = [
      "LIBVA_DRIVER_NAME, radeonsi"
      "HYPRCURSOR_THEME, ${config.gtk.cursorTheme.name}"
      "HYPRCURSOR_SIZE, ${toString config.gtk.cursorTheme.size}"
    ];
  };
}
