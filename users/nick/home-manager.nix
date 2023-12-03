{ inputs, ... }:

{ config, lib, pkgs, ... }:

let
  # inherit (lib) mkIf;
  # hasPackage = pname: lib.any (p: p ? pname && p.pname == pname) config.home.packages;
  # hasExa = hasPackage "eza";

  manpager = (pkgs.writeShellScriptBin "manpager" (''
    exec cat "$@" | col -bx | bat --language man --style plain
  ''));

in {
  # Home-manager 22.11 requires this be set. We never set it so we have
  # to use the old state version.
  home.stateVersion = "23.05";

  imports = [
    ./nix-index.nix
    ./neovim.nix
    ./sway
  #  ./nvchad
  #  ./waybar
  ];

  xdg.enable = true;

  #---------------------------------------------------------------------
  # Packages
  #---------------------------------------------------------------------

  # Packages I always want installed. Most packages I install using
  # per-project flakes sourced with direnv and nix-shell, so this is
  # not a huge list.
  home.packages = with pkgs; [
    fd
    eza
    cargo
    fzf
    kubectl
    kubectl-cnpg
    kubectl-view-secret
    fluxcd
    stern
    kubernetes-helm
    talosctl
    terraform
    cilium-cli
    gh
    grc
    htop
    btop
    gcc
    jq
    tree
    pre-commit
    watch
    nodejs
    chromium
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
    MANPAGER = "${manpager}/bin/manpager";
  };

  # home.file.".gdbinit".source = ./gdbinit;
  # home.file.".inputrc".source = ./inputrc;

  xdg.configFile = {
    # "sway/config".text = builtins.readFile ./sway-config;
    # "nvim".source = "${pkgs.astronvim}";
  #   "rofi/config.rasi".text = builtins.readFile ./rofi;
  #
  #   # tree-sitter parsers
  #   "nvim/parser/proto.so".source = "${pkgs.tree-sitter-proto}/parser";
  #   "nvim/queries/proto/folds.scm".source =
  #     "${sources.tree-sitter-proto}/queries/folds.scm";
  #   "nvim/queries/proto/highlights.scm".source =
  #     "${sources.tree-sitter-proto}/queries/highlights.scm";
  #   "nvim/queries/proto/textobjects.scm".source =
  #     ./textobjects.scm;
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
 
  programs.direnv = {
    enable = true;

    config = {
      whitelist = {
        prefix= [
          "$HOME/Projects"
        ];
        exact = ["$HOME/.envrc"];
      };
    };
  };

  programs.starship = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./starship.toml);
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
      # batman
      batgrep
      batwatch
    ];
  };
  
  programs.git = {
    enable = true;
    userName = "Nick M";
    userEmail = "4718+rkage@users.noreply.github.com";
    aliases = {
      cleanup = "!git branch --merged | grep  -v '\\*\\|master\\|develop' | xargs -n 1 -r git branch -d";
      prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      root = "rev-parse --show-toplevel";
    };
    extraConfig = {
      gpg.format = "ssh";
      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKh6CYAVDuF1quDBHTpbPrLNNq95kCXif4rvrMby38Lb";
      branch.autosetuprebase = "always";
      color.ui = true;
      # core.askPass = ""; # needs to be empty to use terminal for ask pass
      # credential.helper = "store"; # want to make this more secure
      github.user = "rkage";
      # push.default = "tracking";
      init.defaultBranch = "main";
      url."git@github.com:mcfio/".insteadOf = "https://github.com/mcfio/";
      url."git@github.com:rkage/".insteadOf = "https://github.com/rkage/";
    };
  };

  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./wezterm.lua;
  };

  # programs.alacritty = {
  #   enable = !isWSL;
  #
  #   settings = {
  #     env.TERM = "xterm-256color";
  #
  #     key_bindings = [
  #       { key = "K"; mods = "Command"; chars = "ClearHistory"; }
  #       { key = "V"; mods = "Command"; action = "Paste"; }
  #       { key = "C"; mods = "Command"; action = "Copy"; }
  #       { key = "Key0"; mods = "Command"; action = "ResetFontSize"; }
  #       { key = "Equals"; mods = "Command"; action = "IncreaseFontSize"; }
  #       { key = "Subtract"; mods = "Command"; action = "DecreaseFontSize"; }
  #     ];
  #   };
  # };
}
