{
  pkgs,
  lib,
  config,
  ...
}: let
  swaylock = "${config.programs.swaylock.package}/bin/swaylock";
  swaymsg = "${config.wayland.windowManager.sway.package}/bin/swaymsg";
  lockTime = 10 * 60;
in {
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = lockTime;
        command = "${swaylock} --daemonize --grace 15";
      }
      {
        timeout = lockTime + 40;
        command = "${swaymsg} 'output * dpms off'";
        resumeCommand = "${swaymsg} 'output * dpms on'";
      }
    ];
  };
}
