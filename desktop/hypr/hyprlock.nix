{ pkgs, ... }:
{
  programs.hyprlock = {
    enable = true;
    package = pkgs.hyprlock;
  };
  programs.hyprlock.settings = {
    source = "$HOME/.cache/wal/colors-hyprland.conf";
    background = [
      {
        path = "$HOME/Pictures/wallpaper/rick-garage.jpg";
        # path = "$wallpaper";
        blur_size = 5;
        blur_passes = 3;
        brightness = 0.6;
      }
    ];

    input-field = [
      {
        size = "6%, 4%";
        outline_thickness = 0;
        dots_rounding = 4;
        dots_spacing = 0.5;
        inner_color = "$background";
        outer_color = "$background $background";
        check_color = "$background $background";
        fail_color = "$background $background";
        font_color = "$color9";
        font_family = "Inter Display";
        fade_on_empty = false;
        fade_timeout = 300;
        shadow_color = "rgba(0, 0, 0, 0.5)";
        shadow_passes = 2;
        shadow_size = 2;
        rounding = 20;
        placeholder_text = "<i></i>";
        fail_text = "<b>FAIL</b>";
        fail_timeout = 300;
        position = "0, -100";
        halign = "center";
        valign = "center";
      }
    ];

    label = [
      {
        text = "cmd[update:1000] date +\"<b>%I</b>\"";
        color = "$color9";
        font_size = 200;
        font_family = "Inter Display";
        shadow_passes = 0;
        shadow_size = 5;
        position = "-120, 410";
        halign = "center";
        valign = "center";
      }
      {
        text = "cmd[update:1000] date +\"<b>%M</b>\"";
        color = "rgba(150, 150, 150, 0.4)";
        font_size = 200;
        font_family = "Inter Display";
        shadow_passes = 0;
        shadow_size = 5;
        position = "120, 230";
        halign = "center";
        valign = "center";
      }
      {
        text = "cmd[update:1000] date +\"<b>%A, %B %d, %Y</b>\"";
        color = "$color4";
        font_size = 40;
        font_family = "Inter Display";
        shadow_passes = 0;
        shadow_size = 4;
        position = "-40, -20";
        halign = "right";
        valign = "top";
      }
      {
        text = "<i>Hello</i> <b>$USER</b>";
        color = "$color5";
        font_size = 40;
        font_family = "Inter Display";
        shadow_passes = 0;
        shadow_size = 4;
        position = "40, -20";
        halign = "left";
        valign = "top";
      }
    ];
  };
}
