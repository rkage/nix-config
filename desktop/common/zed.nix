{ lib, pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
    ];
  };

  programs.zed-editor.userSettings = {
    base_keymap = "VSCode";
    auto_update = false;
    telemetry = {
      metrics = false;
      diagnostics = false;
    };
    vim_mode = true;
    ui_font_size = 14;
    buffer_font_size = 12;
    buffer_font_family = "MonoLisa";
    theme = {
      mode = "system";
      light = "One Dark";
      dark = "Github Dark Dimmed";
    };
    git_status = true;
    git_panel.dock = "right";
    preferred_line_length = 240;
    soft_wrap = "preferred_line_length";
    terminal = {
      font_family = "MonoLisa";
      line_height = "standard";
      cursor_shape = "underline";
      copy_on_select = true;
    };
    scrollbar.show = "never";
    indent_guides.coloring = "indent_aware";
    "experimental.theme_overrides" = {
      background = "#191c1fee";
      "editor.background" = "#191c1f00";
      "editor.gutter.background" = "#191c1f00";
      syntax.comment.font_style = "italic";
      syntax."comment.doc".font_style = "italic";
    };
    lsp.nix.binary.path_lookup = true;
    languages = {
      Nix = {
        language_servers = [
          "nil"
          "!nixd"
        ];
        formatter.external.command = lib.getExe pkgs.nixfmt-rfc-style;
      };
    };
  };
}
