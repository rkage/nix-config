{
  lib,
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [
    inputs.nvchad4nix.homeManagerModule

    ../cli
    ../desktop/hypr
  ];

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };
  };

  systemd.user.startServices = "sd-switch";

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };
  programs.command-not-found.enable = false;
  news.display = "silent";

  home = {
    username = lib.mkDefault "nick";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "24.11";
    sessionPath = [ "$HOME/.local/bin" ];
    sessionVariables = {
      FLAKE = "$HOME/Projects/nix-config";
    };
  };
}
