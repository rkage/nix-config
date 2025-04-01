{
  programs.ghostty.enable = true;
  programs.ghostty.settings = {
    theme = "nord";
    font-size = 9;
    font-family = "MonoLisa";
    font-feature = [
      "zero"
      "ss02"
      "ss03"
      "ss06"
      "ss07"
      "ss10"
      "ss11"
      "ss13"
      "ss16"
    ];
    background = "#191c1f";
    window-padding-x = 4;
    gtk-single-instance = true;
    keybind = [
      "alt+c=copy_to_clipboard"
      "alt+v=paste_from_clipboard"
      "ctrl+shift+c=copy_to_clipboard"
      "ctrl+shift+v=paste_from_clipboard"
    ];
  };

  xdg.mimeApps = {
    associations.added = {
      "x-scheme-handler/terminal" = "com.mitchellh.ghostty.desktop";
    };
    defaultApplications = {
      "x-scheme-handler/terminal" = "com.mitchellh.ghostty.desktop";
    };
  };
}
