{ lib, ... }:
{
  # Ensure unfree packages are allowed for 1Password
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "1password-gui"
      "1password"
    ];

  # Enable 1Password and configure polkit policy owner(s)
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "nick" ];
  };
}
