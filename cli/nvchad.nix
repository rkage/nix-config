{ pkgs, ... }:
{
  programs.nvchad = {
    enable = true;
    extraPackages = with pkgs; [
      vscode-langservers-extracted
      nixd
    ];
    hm-activation = false;
    backup = false;
  };
}
