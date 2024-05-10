{pkgs, ...}: {
  services.mako = {
    enable = true;
    iconPath = "${pkgs.nordic}/share/icons/Nordic-darker";
    font = "Inter 12";
    padding = "15";
    margin = "15,5";
    anchor = "top-right";
    width = 300;
    height = 100;
    maxIconSize = 48;
    borderSize = 2;
    borderRadius = 12;
    defaultTimeout = 12000;
    backgroundColor = "#1b1f28dd";
    borderColor = "#81a1c1dd";
    textColor = "#d8dee9dd";
    progressColor = "over #ff0000";
    layer = "overlay";
    extraConfig = ''
      max-history=50
      [urgency=critical]
      border-color=#bf616a
      text-color=#d8dee9
      default-timeout=0
    '';
  };
}
