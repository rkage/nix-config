{
  config,
  pkgs,
  ...
}: {
  home.sessionVariables.EDITOR = "nvim";

  home.packages = with pkgs; [
    # dev utils - will go in neovim
    nodejs
    nixd
    alejandra
    gcc
  ];

  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile."nvim" = {
    source = ./nvchad;
    recursive = true;
  };
}
