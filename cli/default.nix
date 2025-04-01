{ pkgs, ... }:
{
  imports = [
    ./bat.nix
    ./fish.nix
    ./eza.nix
    ./git.nix
    ./nvchad.nix
    ./mise.nix
    ./starship.nix
    ./wallust.nix
    ./kubernetes.nix
  ];

  home.packages = with pkgs; [
    unzip
    nil
    alejandra
    nixfmt-rfc-style
    go-task
    jq
    pywal16
    bambu-studio
  ];
}
