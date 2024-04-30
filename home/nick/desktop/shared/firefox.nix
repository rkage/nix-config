{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    profiles.nick = {
      bookmarks = {};
      extensions = with pkgs.inputs.firefox-addons; [
        ublock-origin
      ];
    };
  };
}
