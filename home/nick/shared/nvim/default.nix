{pkgs, ...}: {
  home.packages = with pkgs; [
    nodejs
    nixd
    alejandra
    nixfmt-rfc-style
    nix-diff
    gcc
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

  xdg.configFile.nvim = {
    source = ./nvchad;
    recursive = true;
  };
}
