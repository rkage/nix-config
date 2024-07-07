{
  pkgs,
  config,
  ...
}: {
  # Git
  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.git.enable
  programs.git = {
    enable = true;
    userName = "Nick M";
    userEmail = "4718+rkage@users.noreply.github.com";
    aliases = {
      cleanup = "!git branch --merged | grep  -v '\\*\\|master\\|develop' | xargs -n 1 -r git branch -d";
      prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      root = "rev-parse --show-toplevel";
    };
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKh6CYAVDuF1quDBHTpbPrLNNq95kCXif4rvrMby38Lb";
    };
    extraConfig = {
      github.user = "rkage";
      init.defaultBranch = "main";
      gpg.format = "ssh";
      gpg."ssh".program = "${pkgs._1password-gui}/bin/op-ssh-sign";
      branch.autosetuprebase = "always";
      color.ui = true;
      url = {
        "git@github.com:mcfio/" = {
          insteadOf = "https://github.com/mcfio/";
        };
        "git@github.com:rkage/" = {
          insteadOf = "https://github.com/rkage/";
        };
      };
    };
  };

  # GitHub CLI
  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.gh.enable
  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };
}
