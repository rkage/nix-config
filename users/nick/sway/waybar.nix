{ pkgs, ... }:

let

  scratchpad = (pkgs.writeShellScriptBin "scratchpad" (''
    exec ${pkgs.sway}/bin/swaymsg -t get_tree | ${pkgs.jq}/bin/jq 'recurse(.nodes[]) | first(select(.name=="__i3_scratch")) | .floating_nodes | length | select(. >= 1)'
  ''));

in
{
  programs.waybar = { 
    enable = true;
    systemd.enable = true;
    settings = [{
      mode = "dock";
      passthrough = false;
      layer = "top";
      position = "top";
      height = 34;
      width = 0;
      spacing = 0;
      margin = "0";
      margin-top = 0;
      margin-bottom = 0;
      margin-left = 0;
      margin-right = 0;
      fixed-center = true;
      ipc = true;
      modules-left = [ "custom/logo" "sway/workspaces" "sway/mode" "sway/window" ];
      modules-right = [ "clock" "custom/scratchpad_indicator" "tray" ];
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
          "3" = "";
          "4" = "";
          "5" = "";
          "6" = "漣";
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
      "sway/mode" = {
        format = "{}";
      };
      "sway/window" = {
        format = "{}";
        max-length = 50;
        icon = false;
      };
      "clock" = {
        interval = 60;
        align = 0;
        tooltip-format = "{:%B %Y}";
        format = "  {:%OI:%M %p}";
        format-alt = "{:%a %b %d, %G}";
      };
      "custom/scratchpad_indicator" = {
        interval = 3;
        exec = "${scratchpad}/bin/scratchpad";
        format = "{} ";
        on-click = "swaymsg 'scratchpad show'";
        on-click-right = "swaymsg 'move scratchpad'";
      };
      "tray" = {
        icon-size = 16;
      	spacing = 10;
      };
    }];
    style = ''
      * {
        margin: 0;
        padding: 0;
      }

      window#waybar {
        font-family: "Inter Nerd Font", "JetBrains Mono", "Iosevka Nerd Font", sans-serif;
        font-size: 12px;
        color: #1B1F28;
        background-color: #2e3440;
        border-bottom: 2px solid #434C5E;
        transition-property: background-color;
        transition-duration: .5s;
      }

      window#waybar.hidden {
          opacity: 0.5;
      }

      @keyframes blink {
        to {
          color: #000000;
        }
      }

      #workspaces {
        font-size: 16px;
        color: #ECEFF4;
        background-color: #434C5E;
        border-radius: 0px 12px 0px 0px;
        padding: 4px;
      }

      #workspaces button {
        color: #ECEFF4;
        border-radius: 12px;
        padding: 0 10px 0 4px;
        margin-right: 2px;
      }

      #workspaces button:hover {
        color: #ECEFF4;
        background: #3b4252;
        border: 1px solid #3b4252;
        box-shadow: inherit;
        text-shadow: inherit;
      }

      #workspaces button.visible {
        background: #4C566A;
      }

      #workspaces button.focused {
        background: #81A1C1;
        color: #2E3440;
      }

      #workspaces button.urgent {
        background: #BF616A;
        color: #2E3440;
      }

      #workspaces button.persistent {
        background: #EBCB8B;
        color: #2E3440;
      }

      #workspaces button.current_output {
      }

      #workspaces button#sway-workspace-1 {
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

      #custom-scratchpad_indicator,
      #clock,
      #mode,
      #window,
      #network {
        color: #d8dee9;
        background: #3B4252;
        border-radius: 12px;
        margin-top: 6px;
        margin-bottom: 6px;
        margin-left: 6px;
        padding: 0px 10px;
      }
      
      #custom-scratchpad_indicator {
        padding-right: 18px;
      }

      #mode {
        background: #5E81AC;
        font-weight: bold;
        font-style: italic;
      }

      #custom-logo {
        font-size: 18px;
        color: #ECEFF4;
        background-color: #434C5E;
        margin: 0;
        padding: 0;
        padding-left: 7px;
        padding-right: 12px;
      }

      #tray {
        background-color: #434C5E;
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
      #tray > .active {
      }
    '';
  };
}
