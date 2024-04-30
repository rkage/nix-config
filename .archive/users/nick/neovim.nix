{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      nvchad
      tree-sitter

      # lua
      lua-language-server
      stylua

      # web
      nodePackages.prettier
      vscode-langservers-extracted

      # misc
      taplo
      shfmt
      yaml-language-server

      # nix
      nixpkgs-fmt
      nil

      # cloud-native
      terraform
      terraform-ls
      helm-ls
      hadolint
    ];
    plugins = [];
  };

  xdg.configFile = {
    "nvim/lua/custom" = {
      source = ./nvchad;
      recursive = true;
    };
    "nvim/parser".source = "${pkgs.symlinkJoin {
      name = "treesitter-parsers";
      paths =
        (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins:
          with plugins; [
            c
            lua
            query
            vim
            vimdoc
          ]))
        .dependencies;
    }}/parser";
  };
}
