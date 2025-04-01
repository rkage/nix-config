{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    package = pkgs.bat;
    config.theme = "base16";
    extraPackages = with pkgs.bat-extras; [
      # batdiff
      batman
      batgrep
      batwatch
    ];
  };
}
