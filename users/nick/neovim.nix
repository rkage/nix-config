{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins = [ ];
  };

  home.packages = with pkgs; [
    wget
    unzip
    ripgrep
    lua-language-server
    stylua
    nil
  ];
}
