{lib, ...}: {
  wayland.windowManager.sway.config = {
    assigns = {
      "4" = [
        {app_id = "^firefox$";}
      ];
    };
    workspaceOutputAssign = [
      {
        workspace = "1";
        output = "DP-3";
      }
      {
        workspace = "2";
        output = "DP-3";
      }
      {
        workspace = "3";
        output = "DP-3";
      }
      {
        workspace = "4";
        output = "DP-5";
      }
      {
        workspace = "5";
        output = "DP-5";
      }
      {
        workspace = "6";
        output = "DP-5";
      }
      {
        workspace = "7";
        output = "DP-5";
      }
      {
        workspace = "8";
        output = "DP-5";
      }
    ];
    defaultWorkspace = "workspace number 1";
  };
}
