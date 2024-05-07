{pkgs, ...}: {
  imports = [
    ./bat.nix
    ./direnv.nix
    ./eza.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./nix-index.nix
    ./password-store.nix
    ./starship.nix
  ];

  home.packages = with pkgs; [
    # dev utils - will go in neovim
    nodejs
    nixd
    alejandra
    gcc

    # kubernetes
    kubectl
    kubecolor
    talosctl
    fluxcd
    stern

    # terraform
    terraform

    # utilities
    age
    sops
    wget
    unzip
    jq
    ripgrep
    pre-commit
    go-task
    grc
  ];
}
