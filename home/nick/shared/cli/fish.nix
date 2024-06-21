{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
  packageNames = map (p: p.pname or p.name or null) config.home.packages;
  hasPackage = name: lib.any (x: x == name) packageNames;
in {
  programs.fish = {
    enable = true;

    shellAbbrs = {
      snr = "sudo nixos-rebuild --flake .";
      snrs = "sudo nixos-rebuild --flake . switch";
      hm = "home-manager --flake .";
      hms = "home-manager --flake . switch";

      # kubectl shorthands
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

    shellAliases = {
      cat = "bat";
      man = "batman";
    };

    interactiveShellInit =
      mkIf (hasPackage "stern") ''${pkgs.stern}/bin/stern --completion fish | source'';

    functions = {
      watch = mkIf (hasPackage "kubecolor") ''
        set -lx KUBECOLOR_FORCE_COLORS true
        command ${pkgs.watch}/bin/watch --color --exec ${pkgs.fish}/bin/fish --command "$argv"
      '';
      kubectl = mkIf (hasPackage "kubecolor") ''
        command kubecolor $argv
      '';
      fish_greeting = "";
      up-or-search = ''
        if commandline --search-mode
            commandline -f history-search-backward
            return
        end

        if commandline --paging-mode
            commandline -f up-line
            return
        end

        set -l lineno (commandline -L)

        switch $lineno
            case 1
                commandline -f history-search-backward
                history merge
            case '*'
                commandline -f up-line
        end
      '';
    };

    plugins = [
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair.src;
      }
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
    ];
  };

  home.sessionVariables = {
    SSH_AUTH_SOCK = "$HOME/.1password/agent.sock";
  };

  programs.zoxide.enable = true;
}
