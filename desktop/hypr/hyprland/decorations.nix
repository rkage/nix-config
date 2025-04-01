{
  wayland.windowManager.hyprland.settings = {
    decoration = {
      rounding = 10;
      rounding_power = 2;
      active_opacity = 0.78;
      inactive_opacity = 0.7;
      shadow = {
        enabled = true;
        range = 15;
        render_power = 5;
        color = "rgba(0, 0, 0, 0.5)";
      };
      blur = {
        enabled = true;
        size = 3;
        passes = 5;
        new_optimizations = true;
        ignore_opacity = true;
        xray = false;
        popups = true;
      };
    };
    animations = {
      enabled = true;
      bezier = [
        "fluid, 0.15, 0.85, 0.25, 1"
        "snappy, 0.3, 1, 0.4, 1"
        "linear, 0, 0, 1, 1"
        "quick, 0.15, 0, 0.1, 1"
        "easeOutQuint, 0.23, 1, 0.32, 1"
        "easeInOutCubic, 0.65, 0.05, 0.36, 1"
        "almostLinear, 0.5, 0.5, 0.75, 1"
      ];
      animation = [
        "windows, 1, 3, fluid, popin 5%"
        "windowsOut, 1, 2.5, snappy"
        "workspaces, 1, 1.7, snappy, slide"
        "global, 1, 10, default"
        "border, 1, 5.39, easeOutQuint"
        "fadeIn, 1, 1.73, almostLinear"
        "fadeOut, 1, 1.46, almostLinear"
        "fade, 1, 3.03, quick"
        "layers, 1, 3.81, easeOutQuint"
        "layersIn, 1, 4, easeOutQuint, fade"
        "layersOut, 1, 1.5, linear, fade"
        "fadeLayersIn, 1, 1.79, almostLinear"
        "fadeLayersOut, 1, 1.39, almostLinear"
      ];
    };
  };
}
