{ pkgs, inputs, ... }:

{
  # https://github.com/nix-community/home-manager/pull/2408
  environment.pathsToLink = [ "/share/fish" ];

  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;

  # Since we're using fish as our shell
  programs.fish.enable = true;

  users.users.nick = {
    isNormalUser = true;
    home = "/home/nick";
    extraGroups = [ "docker" "wheel" ];
    shell = pkgs.fish;
    hashedPassword = "$y$j9T$tXwNw3NZpZgJiDoqinOck/$YK4gafuOdGYobe79UDKbe2eqgEamdooSzXfIu7E5e1.";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIERcKVgESQD/jYSiHsIRvN6+PBZjlOt7e3FPzuuV5Urt"
    ];
  };

  # nixpkgs.overlays = import ../../lib/overlays.nix ++ [
  #   (import ./vim.nix { inherit inputs; })
  # ];
}
