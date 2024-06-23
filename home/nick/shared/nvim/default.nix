{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      nodejs
      nixd
      alejandra
      nixfmt-rfc-style
      nix-diff
      gcc
    ];
  };

  xdg.configFile.nvim = {
    source = ./nvchad;
    recursive = true;
  };
}
