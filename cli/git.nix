{ lib, pkgs, ... }:
{
  # Git
  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.git.enable
  programs.git = {
    enable = true;
    userName = "Nick M";
    userEmail = "4718+rkage@users.noreply.github.com";
    aliases = {
      cleanup = "!git branch --merged | grep  -v '\\*\\|main\\|develop' | xargs -n 1 -r git branch -d";
      prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      root = "rev-parse --show-toplevel";
    };
    # Available in home-manager 25.05
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKh6CYAVDuF1quDBHTpbPrLNNq95kCXif4rvrMby38Lb";
      format = "ssh";
      signByDefault = true;
      signer = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
    };
  };

  programs.git.extraConfig = {
    github.user = "rkage";
    init.defaultBranch = "main";
    color.ui = true;
    pull.ff = "only";
    url."git@github.com:mcfio/".insteadOf = "https://github.com/mcfio/";
    url."git@github.com:rkage/".insteadOf = "https://github.com/rkage/";
    # TODO: Remove in home-manager 25.05
    # user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKh6CYAVDuF1quDBHTpbPrLNNq95kCXif4rvrMby38Lb";
    # gpg.format = "ssh";
    # gpg."ssh".program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
    # commit.gpgSign = true;
    # tag.gpgSign = true;
  };

  # GitHub CLI
  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.gh.enable
  programs.gh.enable = true;
}
