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
    # kubernetes
    kubectl
    kubectl-cnpg
    kubecolor
    kubevirt
    kustomize
    (wrapHelm kubernetes-helm {
      plugins = with kubernetes-helmPlugins; [
        helm-diff
        helm-git
      ];
    })
    helmfile
    talosctl
    fluxcd
    stern
    cilium-cli
    hubble

    # terraform
    terraform

    # utilities
    age
    sops
    wget
    unzip
    jq
    yq-go
    ripgrep
    pre-commit
    go-task
    envsubst
    grc
    rpi-imager
  ];
}
