{lib, ...}: {
  wayland.windowManager.sway.config = let
    displayLeft = "HDMI-A-1";
    displayRight = "HDMI-A-2";
  in {
    assigns = {
      "4" = [
        {app_id = "^firefox$";}
      ];
      "0" = [
        {class = "^vesktop";}
      ];
    };
    workspaceOutputAssign = [
      {
        workspace = "1";
        output = "${displayLeft}";
      }
      {
        workspace = "2";
        output = "${displayLeft}";
      }
      {
        workspace = "3";
        output = "${displayLeft}";
      }
      {
        workspace = "4";
        output = "${displayRight}";
      }
      {
        workspace = "5";
        output = "${displayRight}";
      }
      {
        workspace = "6";
        output = "${displayRight}";
      }
      {
        workspace = "7";
        output = "${displayRight}";
      }
      {
        workspace = "8";
        output = "${displayRight}";
      }
    ];
    defaultWorkspace = "workspace number 1";
  };
}
