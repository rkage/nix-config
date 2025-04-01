{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  packageNames = map (p: p.pname or p.name or null) config.home.packages;
  hasPackage = name: lib.any (x: x == name) packageNames;
in
{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      snr = "sudo nixos-rebuild --flake .";
      snrs = "sudo nixos-rebuild --flake . switch";
      hm = "home-manager --flake .";
      hms = "home-manager --flake . switch";
    };
    functions = {
      fish_greeting = "";
      watch = mkIf (hasPackage "kubecolor") ''
        set -lx KUBECOLOR_FORCE_COLORS true
        command ${pkgs.watch}/bin/watch --color --exec ${pkgs.fish}/bin/fish --command "$argv"
      '';
    };
  };

  programs.nix-index.enable = true;
  programs.nix-index.enableFishIntegration = true;

  home.sessionVariables = {
    SSH_AUTH_SOCK = "$HOME/.1password/agent.sock";
  };

  programs.zoxide.enable = true;
}
