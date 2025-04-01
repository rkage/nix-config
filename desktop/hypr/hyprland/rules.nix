{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "tag +dialog, title:^(Open File)(.*)$"
      "tag +dialog, title:^(Select a File)(.*)$"
      "tag +dialog, title:^(Choose wallpaper)(.*)$"
      "tag +dialog, title:^(Open Folder)(.*)$"
      "tag +dialog, title:^(Save As)(.*)$"
      "tag +dialog, title:^(Library)(.*)$"
      "tag +dialog, title:^(File Upload)(.*)$"
      "float, tag:dialog"
      "size 1160 640, tag:dialog"
      "center, tag:dialog"

      "float, title:(1Password)"
      "size 60% 60%, title:(1Password)"
      "center, title:(1Password)"

      "float, class:legcord"
      "size 1490 870, title:(.*)(- Legcord)$"
      "move 1040 64, title:(.*)(- Legcord)$"

      "suppressevent maximize, class:.*"
      "nofocus, class:^$,title:^$, xwayland:1, floating:1, fullscreen:0, pinned:0"
    ];

    layerrule = [
      "blur, wofi"
      "ignorezero, wofi"
    ];

    workspace = [
      "1, default:true"
    ];
  };
}
