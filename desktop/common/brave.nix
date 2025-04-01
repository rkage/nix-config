{
  programs.brave.enable = true;
  programs.brave.extensions = [
    "aeblfdkhhhdcdjpifhhbdiojplfjncoa"
  ];

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "brave.desktop" ];
    "text/xml" = [ "brave.desktop" ];
    "x-scheme-handler/http" = [ "brave.desktop" ];
    "x-scheme-handler/https" = [ "brave.desktop" ];
  };
}
