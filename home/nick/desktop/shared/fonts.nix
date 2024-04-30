{ pkgs, ... }: {

  home.packages = with pkgs; [
    inter-ui
    iosevka
    noto-fonts
    jetbrains-mono
    (nerdfonts.override { fonts = ["NerdFontsSymbolsOnly" ]; })
  ];
  fonts.fontconfig.enable = true;

  # fontProfiles = {
  #   enable = true;
  #   monospace = {
  #     family = "Noto Sans Mono";
  #     package = pkgs.noto-fonts;
  #   };
  #   regular = {
  #     family = "
  #   };
}
