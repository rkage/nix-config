{
  pkgs,
  inputs,
  ...
}: {
  # https://github.com/nix-community/home-manager/pull/2408
  environment.pathsToLink = ["/share/fish"];

  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;

  # Since we're using fish as our shell
  programs.fish.enable = true;

  # Additional system packages required.
  environment.systemPackages = with pkgs; [
    polkit_gnome
  ];

  # 1Password is not in home-manager, therefore needs to be configured here
  # Additional componens need to be configured at a system level and require
  # SUID wrappers in some cases.
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["nick"];
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  users.users.nick = {
    isNormalUser = true;
    home = "/home/nick";
    extraGroups = ["docker" "wheel"];
    shell = pkgs.fish;
    hashedPassword = "$y$j9T$tXwNw3NZpZgJiDoqinOck/$YK4gafuOdGYobe79UDKbe2eqgEamdooSzXfIu7E5e1.";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIERcKVgESQD/jYSiHsIRvN6+PBZjlOt7e3FPzuuV5Urt"
    ];
  };

  nixpkgs.overlays = import ../../lib/overlays.nix;
}
