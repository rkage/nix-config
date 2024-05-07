{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [vesktop];

  # xdg.configFile."vesktop/themes/nordic.css".text = ''
  #   @import url("https://raw.githubusercontent.com/orblazer/discord-nordic/master/nordic.vencord.css");
  # '';
}
