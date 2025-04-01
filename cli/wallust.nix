{pkgs, ...}: {
  home.packages = with pkgs; [
    wallust
  ];

  xdg.configFile."wallust/wallust.toml".text = ''
    [templates]
    hypr = { src = "hyprland-colors.conf", dst = "~/.config/hypr/colors.conf" }
    waybar = { src = "colors.css", dst = "~/.config/waybar/colors.css" }
    wofi = { src = "colors.css", dst = "~/.config/wofi/colors.css" }
  '';

  xdg.configFile."wallust/templates/hyprland-colors.conf".text = ''
    general {
        col.active_border = rgba({{color3 | strip}}ee)
        col.inactive_border = rgba({{color8 | strip}}aa)
    }
  '';

  xdg.configFile."wallust/templates/colors.css".text = ''
    @define-color background     {{color0}};
    @define-color background-alt {{color8 | darken(0.2)}};
    @define-color border         {{color8}};
    @define-color foreground     {{color7}};
    @define-color active         #81a1c1;
    @define-color inactive       {{color9}};
    @define-color urgent         {{color2}};
    @define-color normal         {{color8}};
  '';
}
