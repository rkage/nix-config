{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    inter
    iosevka
    noto-fonts
    nerd-fonts.symbols-only # home-manager >= 25.05
  ];

  # TODO Figure out how to roll my MonoLisa font as a package.
}
