{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.nick = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "video"
      "audio"
    ] ++ ifTheyExist [
      "i2c"
    ];
    hashedPasswordFile = config.sops.secrets.nick-password.path;
    packages = [
      pkgs.home-manager
      pkgs.polkit_gnome
    ];
  };

  sops.secrets.nick-password = {
    file = ../../secrets.sops.yaml;
    neededForUsers = true;
  };

  security.pam.services.swaylock = {};
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "nick" ];
  };

  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function (action, subject) {
        if ((
          action.id == "com.1password.1Password.unlock" ||
          action.id == "com.1password.1Password.authorizeSshAgent"
        ) &&
          subject.isInGroup("wheel")
        ) {
          return polkit.Result.YES;
        }
      });
    '';
  };

  home-manager.users.nick = import ../../../../home/nick/${config.networking.hostName}.nix;
}
