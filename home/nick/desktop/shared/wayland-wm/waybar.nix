{pkgs, ...}: let
  scratchpad = pkgs.writeShellScriptBin "scratchpad" ''
    exec ${pkgs.sway}/bin/swaymsg -t get_tree | ${pkgs.jq}/bin/jq 'recurse(.nodes[]) | first(select(.name=="__i3_scratch")) | .floating_nodes | length | select(. >= 1)'
  '';
in {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = [
      {
        mode = "dock";
        passthrough = false;
        layer = "top";
        position = "top";
        height = 32;
        width = 0;
        spacing = 0;
        margin = "0";
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;
        fixed-center = true;
        ipc = false;
        modules-left = ["custom/logo" "sway/workspaces" "sway/mode" "sway/window"];
        modules-right = ["wireplumber" "network" "clock" "idle_inhibitor" "custom/scratchpad_indicator" "custom/notification" "tray"];
        "custom/logo" = {
          format = "";
          tooltip = false;
        };
        "sway/workspaces" = {
          disable-scroll = false;
          disable-click = false;
          all-outputs = false;
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "󱃾";
            "4" = "";
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
          window-rewrite = {};
        };
        "sway/mode" = {
          format = "{}";
        };
        "sway/window" = {
          format = "{}";
          max-length = 75;
          icon = false;
        };
        "wireplumber" = {
          format = "{icon} {volume}%";
          format-muted = " Mute";
          on-click = "helvum";
          format-icons = ["" "" ""];
        };
        "network" = {
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
        "clock" = {
          interval = 60;
          align = 0;
          tooltip-format = "{:%B %Y}";
          format = " {:%OI:%M %p}";
          format-alt = "{:%a %b %d, %G}";
        };
        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        "custom/scratchpad_indicator" = {
          interval = 3;
          exec = "${scratchpad}/bin/scratchpad";
          format = "{} ";
          on-click = "swaymsg 'scratchpad show'";
          on-click-right = "swaymsg 'move scratchpad'";
        };
        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
          };
          return-type = "json";
          exec = "${pkgs.swaynotificationcenter}/bin/swaync-client -swb";
          on-click = "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
          on-click-right = "${pkgs.swaynotificationcenter}/bin/swaync-client -d -sw";
          escape = true;
        };
        "tray" = {
          icon-size = 18;
          spacing = 10;
        };
      }
    ];
    style = ''
      * {
        font-family: ${pkgs.iosevka.pname}, "Symbols Nerd Font Mono", sans-serif;
        font-size: 12px;
        margin: 0;
        padding: 0;
      }

      window#waybar {
        color: #1b1f28;
        background-color: #2e3440;
        border-bottom: 2px solid #434c5e;
      }

      #custom-logo {
        font-size: 20px;
        color: #eceff4;
        background-color: #434c5e;
        padding-top: 2px;
        padding-left: 4px;
        padding-right: 6px;
      }

      #workspaces {
        font-size: 14px;
        color: #eceff4;
        background-color: #434c5e;
        border-radius: 0px 12px 0px 0px;
        padding-top: 4px;
        padding-bottom: 4px;
        padding-right: 4px;
      }

      #workspaces button {
        color: #eceff4;
        border: 0;
        border-radius: 8px;
        padding-left: 8px;
        padding-right: 8px;
      }

      #workspaces button:hover {
        color: #eceff4;
        background: #4c5668;
        box-shadow: inherit;
        text-shadow: inherit;
      }

      #workspaces button.visible {
        background: #4c566a;
      }

      #workspaces button.focused {
        background: #81a1c1;
        color: #2e3440;
      }

      #workspaces button.urgent {
        background: #bf616a;
        color: #2e3440;
      }

      #workspaces button.persistent {
        background: #ebcb8b;
        color: #2e3440;
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
      #window,
      #wireplumber,
      #network {
        color: #d8dee9;
        background: #3b4252;
        border-radius: 12px;
        margin-top: 4px;
        margin-bottom: 6px;
        margin-left: 6px;
        padding: 2px 10px;
      }

      #custom-scratchpad_indicator {
        padding-right: 18px;
      }

      #idle_inhibitor {
        font-size: 16px;
      }

      #idle_inhibitor.activated {
        background-color: #a3be8c;
        color: #2e3440;
      }

      #wireplumber.muted {
        background-color: #bf616a;
      }

      #mode {
        background: #5e81ac;
        font-weight: bold;
      }

      #tray {
        background-color: #434c5e;
        border-radius: 12px 0px 0px 0px;
        padding: 2px 12px;
        margin-left: 6px;
      }
      #tray > .passive {
        -gtk-icon-effect: dim;
      }
      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
      }
    '';
  };
}
