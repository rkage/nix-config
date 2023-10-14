{ inputs, ... }:

{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;
  hasPackage = pname: lib.any (p: p ? pname && p.pname == pname) config.home.packages;
  hasExa = hasPackage "eza";

  manpager = (pkgs.writeShellScriptBin "manpager" (''
    exec cat "$@" | col -bx | bat --language man --style plain
  ''));

in {

  imports = [
  #  ./nvchad
  #  ./waybar
  ];
  # Home-manager 22.11 requires this be set. We never set it so we have
  # to use the old state version.
  home.stateVersion = "23.05";

  xdg.enable = true;

  #---------------------------------------------------------------------
  # Packages
  #---------------------------------------------------------------------

  # Packages I always want installed. Most packages I install using
  # per-project flakes sourced with direnv and nix-shell, so this is
  # not a huge list.
  home.packages = with pkgs; [
    bat
    fd
    inputs.eza.packages.${pkgs.system}.default
    fzf
    kubectl
    fluxcd
    gh
    grc
    zoxide
    htop
    btop
    gcc
    lua-language-server
    jq
    ripgrep
    tree
    pre-commit
    watch
    wezterm
    nodejs
    chromium
    firefox
    clipman
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
    # MANPAGER = "sh -c 'col -bx | bat --language man --style plain";
    MANPAGER = "${manpager}/bin/manpager";
  };

  # home.file.".gdbinit".source = ./gdbinit;
  # home.file.".inputrc".source = ./inputrc;

  xdg.configFile = {
    "sway/config".text = builtins.readFile ./sway-config;
    "wezterm/wezterm.lua".text = builtins.readFile ./wezterm.lua;
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
 
  # programs.gpg.enable = !isDarwin;

  programs.waybar = { 
    enable = true;
    systemd.enable = true;
    settings = [{
      mode = "dock";
      passthrough = false;
      layer = "top";
      position = "top";
      height = 32;
      width = 0;
      spacing = 0;
      margin = "0";
      margin-top = 0;
      margin-bottom = 0;
      margin-left = 0;
      margin-right = 0;
      fixed-center = true;
      ipc = true;
      modules-left = [ "custom/logo" "sway/workspaces" "sway/mode" "sway/window" ];
      modules-right = [ "tray" ];
      "custom/logo" = {
        format = "";
      	tooltip = false;
      };
      "sway/workspaces" = {
        disable-scroll = false;
        disable-click = false;
        all-outputs = false;
        format = "{icon}";
        format-icons = {
          "1" = "";
          "2" = "";
          "3" = "";
          "4" = "";
          "5" = "";
          "6" = "漣";
          "7" = "";
          "8" = "";
          "9" = "";
          "10" = "";
          urgent = "";
          default = "";
        };
        smooth-scrolling-threshold = 1;
        disable-scroll-wraparound = false;
        enable-bar-scroll = false;
        disable-markup = false;
        current-only = false;
      };
      "sway/mode" = {
        format = "{}";
      };
      "sway/window" = {
        format = "{}";
        max-length = 50;
        icon = false;
      };
      "tray" = {
        icon-size = 16;
      	spacing = 10;
      };
    }];
    style = builtins.readFile ./waybar/style.css;
  };

  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML ./starship.toml;
  };

  # programs.bash = {
  #   enable = true;
  #   shellOptions = [];
  #   historyControl = [ "ignoredups" "ignorespace" ];
  #   initExtra = builtins.readFile ./bashrc;
  #
  #   shellAliases = {
  #     ga = "git add";
  #     gc = "git commit";
  #     gco = "git checkout";
  #     gcp = "git cherry-pick";
  #     gdiff = "git diff";
  #     gl = "git prettylog";
  #     gp = "git push";
  #     gs = "git status";
  #     gt = "git tag";
  #   };
  # };
  #
  # programs.direnv= {
  #   enable = true;
  #
  #   config = {
  #     whitelist = {
  #       prefix= [
  #         "$HOME/code/go/src/github.com/hashicorp"
  #         "$HOME/code/go/src/github.com/mitchellh"
  #       ];
  #
  #       exact = ["$HOME/.envrc"];
  #     };
  #   };
  # };
  #
  programs.fish = {
    enable = true;
    interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" ([
      (builtins.readFile ./config.fish)
      "set fish_greeting"
      "set -g SHELL ${pkgs.fish}/bin/fish"
    ]));

    shellAbbrs = rec {
      exa = "eza";
    };
    shellAliases = {
      ls = "eza";
  #     ga = "git add";
  #     gc = "git commit";
  #     gco = "git checkout";
  #     gcp = "git cherry-pick";
  #     gdiff = "git diff";
  #     gl = "git prettylog";
  #     gp = "git push";
  #     gs = "git status";
  #     gt = "git tag";
  #   } // (if isLinux then {
  #     # Two decades of using a Mac has made this such a strong memory
  #     # that I'm just going to keep it consistent.
  #     pbcopy = "xclip";
  #     pbpaste = "xclip -o";
  #   } else {});
    };

    plugins = [
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      { name = "autopair"; src = pkgs.fishPlugins.autopair.src; }
      { name = "forgit"; src = pkgs.fishPlugins.forgit.src; }
      { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
    ];
  };
  
  programs.git = {
    enable = true;
    userName = "Nick M";
    userEmail = "4718+rkage@users.noreply.github.com";
  #   aliases = {
  #     cleanup = "!git branch --merged | grep  -v '\\*\\|master\\|develop' | xargs -n 1 -r git branch -d";
  #     prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
  #     root = "rev-parse --show-toplevel";
  #   };
    extraConfig = {
      gpg.format = "ssh";
      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKh6CYAVDuF1quDBHTpbPrLNNq95kCXif4rvrMby38Lb";
  #     branch.autosetuprebase = "always";
  #     color.ui = true;
  #     core.askPass = ""; # needs to be empty to use terminal for ask pass
  #     credential.helper = "store"; # want to make this more secure
      github.user = "rkage";
  #     push.default = "tracking";
      init.defaultBranch = "main";
      url."git@github.com:mcfio/".insteadOf = "https://github.com/mcfio/";
      url."git@github.com:rkage/".insteadOf = "https://github.com/rkage/";
    };
  };

  # programs.go = {
  #   enable = true;
  #   goPath = "code/go";
  #   goPrivate = [ "github.com/mitchellh" "github.com/hashicorp" "rfc822.mx" ];
  # };
  #
  # programs.tmux = {
  #   enable = true;
  #   terminal = "xterm-256color";
  #   shortcut = "l";
  #   secureSocket = false;
  #
  #   extraConfig = ''
  #     set -ga terminal-overrides ",*256col*:Tc"
  #
  #     set -g @dracula-show-battery false
  #     set -g @dracula-show-network false
  #     set -g @dracula-show-weather false
  #
  #     bind -n C-k send-keys "clear"\; send-keys "Enter"
  #
  #     run-shell ${sources.tmux-pain-control}/pain_control.tmux
  #     run-shell ${sources.tmux-dracula}/dracula.tmux
  #   '';
  # };
  #
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
  #
  # programs.kitty = {
  #   enable = !isWSL;
  #   extraConfig = builtins.readFile ./kitty;
  # };
  #
  # programs.i3status = {
  #   enable = isLinux && !isWSL;
  #
  #   general = {
  #     colors = true;
  #     color_good = "#8C9440";
  #     color_bad = "#A54242";
  #     color_degraded = "#DE935F";
  #   };
  #
  #   modules = {
  #     ipv6.enable = false;
  #     "wireless _first_".enable = false;
  #     "battery all".enable = false;
  #   };
  # };
  #
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    withPython3 = true;

    plugins = with pkgs.vimPlugins; [
      luasnip
    ];
  };
  #
  #   withPython3 = true;
  #
  #   plugins = with pkgs; [
  #     customVim.vim-copilot
  #     customVim.vim-cue
  #     customVim.vim-fish
  #     customVim.vim-fugitive
  #     customVim.vim-glsl
  #     customVim.vim-misc
  #     customVim.vim-pgsql
  #     customVim.vim-tla
  #     customVim.vim-zig
  #     customVim.pigeon
  #     customVim.AfterColors
  #
  #     customVim.vim-nord
  #     customVim.nvim-comment
  #     customVim.nvim-lspconfig
  #     customVim.nvim-plenary # required for telescope
  #     customVim.nvim-telescope
  #     customVim.nvim-treesitter
  #     customVim.nvim-treesitter-playground
  #     customVim.nvim-treesitter-textobjects
  #
  #     vimPlugins.vim-airline
  #     vimPlugins.vim-airline-themes
  #     vimPlugins.vim-eunuch
  #     vimPlugins.vim-gitgutter
  #
  #     vimPlugins.vim-markdown
  #     vimPlugins.vim-nix
  #     vimPlugins.typescript-vim
  #   ] ++ (lib.optionals (!isWSL) [
  #     # This is causing a segfaulting while building our installer
  #     # for WSL so just disable it for now. This is a pretty
  #     # unimportant plugin anyway.
  #     customVim.vim-devicons
  #   ]);
  #
  #   extraConfig = (import ./vim-config.nix) { inherit sources; };
  # };
  #
  # services.gpg-agent = {
  #   enable = isLinux;
  #   pinentryFlavor = "tty";
  #
  #   # cache the keys forever so we don't get asked for a password
  #   defaultCacheTtl = 31536000;
  #   maxCacheTtl = 31536000;
  # };
  #
  # xresources.extraConfig = builtins.readFile ./Xresources;
  #
  # # Make cursor not tiny on HiDPI screens
  # home.pointerCursor = lib.mkIf (isLinux && !isWSL) {
  #   name = "Vanilla-DMZ";
  #   package = pkgs.vanilla-dmz;
  #   size = 128;
  #   x11.enable = true;
  # };
}
