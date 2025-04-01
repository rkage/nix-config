{ lib, pkgs, ... }:
{
  services.hypridle.enable = true;
  services.hypridle.settings = {
    general = {
      lock_cmd = "pidof hyprlock || ${lib.getExe pkgs.hyprlock}";
      before_sleep_cmd = "loginctl lock-session";
      after_sleep_cmd = "hyprctl dispatch dpms on";
    };

    # Dim display after 20 minutes of idle
    # listener {
    #     timeout = 1200
    #     on-timeout = brightnessctl -s set 10
    #     on-resume = brightnessctl -r
    # }

    # Turn off display after 22 minutes
    listener = [
      {
        timeout = 1320;
        on-timeout = "hyprctl dispatch dpms off";
        on-resume = "hyprctl dispatch dpms on";
      }

      # Lock machine after 25 minutes
      {
        timeout = 1500;
        on-timeout = "loginctl lock-session";
      }

      # Suspend machine after 30 minutes
      {
        timeout = 1800;
        on-timeout = "systemctl suspend";
      }
    ];
  };
}
