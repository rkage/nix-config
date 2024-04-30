{
  config,
  pkgs,
  ...
}: {
  home.sessionVariables.EDITOR = "nvim";

  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
  };

  # xdg.configFile."nvim" = {
  #   source = ./nvchad;
  #   recursive = true;
  # };
}
