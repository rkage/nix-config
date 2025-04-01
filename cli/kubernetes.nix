{ pkgs, ... }:
let
  wrappedHelmPkg = pkgs.wrapHelm pkgs.kubernetes-helm {
    plugins = with pkgs.kubernetes-helmPlugins; [
      helm-diff
      helm-git
      helm-s3
      helm-secrets
    ];
  };
in
{
  home.packages =
    (with pkgs; [
      fluxcd
      krew
      kubecolor
      kustomize
      kubectl
      kubectl-view-secret
      kubectl-klock
      kubectl-neat
      helmfile
      talosctl
      stern
    ])
    ++ [
      wrappedHelmPkg
    ];

  programs.fish = {
    interactiveShellInit = ''
      fish_add_path $HOME/.krew/bin
    '';

    functions = {
      kyaml = {
        description = "Clean up kubectl get yaml output";
        body = ''
          kubectl get $argv -o yaml | kubectl-neat
        '';
      };
      # watch = mkIf (hasPackage "kubecolor") ''
      #   set -lx KUBECOLOR_FORCE_COLORS true
      #   command ${pkgs.watch}/bin/watch --color --exec ${pkgs.fish}/bin/fish --command "$argv"
      # '';
      # kubectl = mkIf (hasPackage "kubecolor") ''
      #   command kubecolor $argv
      # '';
    };

    shellAliases = {
      # kubectl shorthands
      kubectl = "kubecolor";
      k = "kubectl";
      kgp = "kubectl get pods";
      kga = "kubectl get pods --all-namespaces";
      kd = "kubectl describe";
      kdp = "kubectl describe pod";
      ke = "kubectl edit";
      kex = "kubectl exec -it";
      kvs = "kubectl view-secret";
      kgno = "kubectl get nodes --sort-by=.metadata.name -o wide";
    };
  };
}
