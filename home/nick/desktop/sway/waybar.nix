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
      modules-left = [ "custom/logo" "sway/workspaces" "sway/mode" "sway/window" ];
      modules-right = [ "wireplumber" "network" "clock" "idle_inhibitor" "custom/scratchpad_indicator" "tray" ];
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
      "tray" = {
        icon-size = 18;
        spacing = 10;
      };
    }];
    style = builtins.readFile ./waybar-style.css;
  };
}
