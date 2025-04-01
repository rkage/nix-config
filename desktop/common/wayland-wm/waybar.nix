{
  programs.waybar.enable = true;
  programs.waybar.settings = {
    main-bar = {
      id = "main-bar";
      mode = "dock";
      exclusive = true;
      passthrough = false;
      layer = "top";
      position = "top";
      height = 0;
      width = 0;
      spacing = 0;
      margin = "0";
      fixed-center = true;
      # Disabled until fixed upstream
      # ipc = true;
      reload_style_on_change = true;
      modules-left = [
        "custom/logo"
        "hyprland/workspaces"
        "hyprland/submap"
        "hyprland/window"
      ];
      modules-right = [
        "network"
        "clock"
        "idle_inhibitor"
        "custom/notification"
        "tray"
      ];

      "custom/logo" = {
        format = "";
        tooltip = false;
      };

      "hyprland/workspaces" = {
        disable-scroll = false;
        disable-click = false;
        all-outputs = false;
        format = "{icon}";
        format-icons = {
          "1" = "";
          "2" = "";
          "3" = "󱃾";
          "4" = "";
          "5" = "";
          "6" = "󰉓";
          "7" = "";
          "8" = "";
          "9" = "";
          "10" = "";
          urgent = "";
          default = "";
        };
        smooth-scrolling-threshold = 1;
        disable-scroll-wraparound = false;
        enable-bar-scroll = false;
        disable-markup = false;
        current-only = false;
      };

      "hyprland/submap" = {
        format = "{}";
      };

      "hyprland/window" = {
        format = "{}";
        max-length = 75;
        icon = false;
      };

      network = {
        interval = 5;
        format-wifi = " {essid}";
        format-ethernet = "󰛳 {ifname}";
        format-linked = "󰛵 {ifname} (No IP)";
        format-disconnected = "󰅛 Disconnected";
        format-disabled = "󰲛 Disabled";
        format-alt = " {bandwidthUpBits} |  {bandwidthDownBits}";
        family = "ipv4";
        tooltip-format = "󰛳 {ifname}\nIP: {ipaddr}\nGW: {gwaddr}";
      };

      clock = {
        interval = 60;
        align = 0;
        rotate = 0;
        tooltip-format = "{:%B %Y}";
        format = " {:%OI:%M %p}";
        format-alt = "{:%a %b %d, %G}";
      };

      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
      };

      "custom/notification" = {
        tooltip = false;
        format = "";
        on-click = "swaync-client -t -sw";
        escape = true;
      };

      tray = {
        icon-size = 18;
        spacing = 6;
      };
    };
  };

  programs.waybar.style = ''
    @import url("colors.css");
    * {
        font-family: "Iosevka", "Symbols Nerd Font Mono", sans-serif;
        padding: 0;
        margin: 0;
    }

    window#waybar {
        font-size: 14px;
        color: #1b1f28;
        background-color: @background;
        border-bottom: 3px solid @border;
    }

    #custom-logo {
        font-size: 20px;
        color: @foreground;
        background-color: @border;
        padding-top: 6px;
        padding-bottom: 5px;
        padding-left: 6px;
        padding-right: 6px;
    }

    #workspaces {
        color: @foreground;
        background-color: @border;
        border-top-right-radius: 9px;
        padding-top: 3px;
        padding-bottom: 4px;
        padding-right: 4px;
    }

    #workspaces button {
        border: 0;
        border-radius: 8px;
        padding-left: 8px;
        padding-right: 8px;
    }

    #workspaces button:hover {
        background: @background-alt;
        box-shadow: inherit;
        text-shadow: inherit;
    }

    #workspaces button.visible {
        background: @background;
    }

    #workspaces button.focused,
    #workspaces button.active {
        color: @background;
        background: @active;
    }

    #workspaces button.urgent {
        color: @background;
        background: @urgent;
    }

    #workspaces button.persistent {
        color: @background;
        background: #ebcb8b;
    }

    .modules-left > widget:first-child > #workspaces {
        margin-left: 0;
    }

    .modules-right > widget:last-child > #workspaces {
        margin-right: 0;
    }

    window#waybar.empty #window {
        background-color: transparent;
    }

    #idle_inhibitor,
    #custom-scratchpad_indicator,
    #custom-notification,
    #clock,
    #mode,
    #submap,
    #window,
    #wireplumber,
    #network {
        font-size: 12px;
        color: @foreground;
        background: @background-alt;
        border-radius: 18px;
        margin-top: 3px;
        margin-bottom: 6px;
        margin-left: 9px;
        padding: 0 15px;
    }

    #custom-scratchpad_indicator {
        padding-right: 18px;
    }

    #idle_inhibitor {
        font-size: 16px;
    }

    #idle_inhibitor.activated {
        color: #2e3440;
        background-color: #a3be8c;
    }

    #wireplumber.muted {
        background-color: #bf616a;
    }

    #mode,
    #submap {
        background-color: #5e81ac;
        font-weight: bold;
    }

    #tray {
        background-color: @border;
        border-top-left-radius: 9px;
        padding: 0 9px;
        margin-left: 9px;
    }
    #tray > .passive {
        -gtk-icon-effect: dim;
    }
    #tray > .needs-attention {
        -gtk-icon-effect: highlight;
    }
  '';
}
