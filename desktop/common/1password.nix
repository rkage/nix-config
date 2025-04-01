{
  xdg.desktopEntries = {
    _1password = {
      name = "1Password";
      exec = "ELECTRON_OZONE_PLATFORM_HINT=auto 1password";
      type = "Application";
      noDisplay = true;
      settings = {
        X-GNOME-Autostart-enabled = "true";
      };
    };
  };
}
