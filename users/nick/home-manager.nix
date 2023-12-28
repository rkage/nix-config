{ inputs, ... }:

{ config, lib, pkgs, ... }:

let
  # inherit (lib) mkIf;
  # hasPackage = pname: lib.any (p: p ? pname && p.pname == pname) config.home.packages;
  # hasExa = hasPackage "eza";

  manpager = (pkgs.writeShellScriptBin "manpager" (
    ''
      exec ${pkgs.coreutils}/bin/cat "$@" | ${pkgs.util-linux}/bin/col -bx | ${pkgs.bat}/bin/bat --language man --style plain
    ''
  ));

in
{
  # Home-manager 22.11 requires this be set.
  home.stateVersion = "23.05";

  imports = [
    ./starship.nix
    ./wezterm.nix
    ./nix-index.nix
    ./neovim.nix
    ./sway
    ./git.nix
  ];

  xdg.enable = true;

  #---------------------------------------------------------------------
  # Packages
  #---------------------------------------------------------------------

  # Packages I always want installed. Most packages I install using
  # per-project flakes sourced with direnv and nix-shell, so this is
  # not a huge list.
  home.packages = with pkgs; [
    age
    sops
    dconf
    wget
    unzip
    ripgrep
    fd
    eza
    cargo
    fzf
    grc
    htop
    btop
    gcc
    jq
    tree
    pre-commit
    watch
    nodejs
    firefox
    python3
  ];

  #---------------------------------------------------------------------
  # Env vars and dotfiles
  #---------------------------------------------------------------------

  home.sessionVariables = {
    LANG = "en_CA.UTF-8";
    LC_CTYPE = "en_CA.UTF-8";
    LC_ALL = "en_CA.UTF-8";
    EDITOR = "nvim";
    PAGER = "less -FirSwX";
    # MANPAGER = "${manpager}/bin/manpager";
    # MANROFFOPT = "-c";
  };

  #---------------------------------------------------------------------
  # Services
  #---------------------------------------------------------------------

  # SystemdD polkit authentication frontend, I happen to like the gnome version
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      Unit = {
        Description = "polkit-gnome-authentication-agent-1";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };

  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------

  programs.chromium = {
    enable = true;
    extensions = [
      "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1Password Extension
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
      "hjdoplcnndgiblooccencgcggcoihigg" # Terms of Service; Didn’t Read
    ];
  };

  programs.direnv = {
    enable = true;

    config = {
      whitelist = {
        prefix = [
          "$HOME/Projects"
        ];
        exact = [ "$HOME/.envrc" ];
      };
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" ([
      (builtins.readFile ./config.fish)
      "set -g SHELL ${pkgs.fish}/bin/fish"
    ]));

    shellAbbrs = {
      exa = "eza";
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
      ls = "eza";
      cat = "bat";
      #   ga = "git add";
      #   gc = "git commit";
      #   gco = "git checkout";
      #   gcp = "git cherry-pick";
      #   gdiff = "git diff";
      #   gl = "git prettylog";
      #   gp = "git push";
      #   gs = "git status";
      #   gt = "git tag";
      # } // (if isLinux then {
      #   # Two decades of using a Mac has made this such a strong memory
      #   # that I'm just going to keep it consistent.
      #   pbcopy = "xclip";
      #   pbpaste = "xclip -o";
      # } else {});
    };

    plugins = [
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      { name = "autopair"; src = pkgs.fishPlugins.autopair.src; }
      { name = "forgit"; src = pkgs.fishPlugins.forgit.src; }
      { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
    ];
  };

  programs.zoxide = {
    enable = true;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "base16-256";
    };
    extraPackages = with pkgs.bat-extras;  [
      batdiff
      batman
      batgrep
      batwatch
    ];
  };
}
