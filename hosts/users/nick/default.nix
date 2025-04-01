{ config, pkgs, ... }:
let
  ifGroupExists = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.users.nick = {
    isNormalUser = true;
    description = "Nick McFaul";
    shell = pkgs.fish;
    extraGroups = ifGroupExists [
      "wheel"
      "video"
      "i2c"
    ];
    packages = [ pkgs.home-manager ];
  };
  services.userborn.enable = true;
  home-manager.users.nick = import ../../../home-manager/home.nix;
}
