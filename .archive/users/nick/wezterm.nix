{ ... }:

{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        -- bell
        audible_bell = "Disabled",
        visual_bell = {
          fade_in_duration_ms = 75,
          fade_out_duration_ms = 75,
          target = "CursorColor"
        },

        -- font
        font = wezterm.font({
          family = "MonoLisa",
          harfbuzz_features = { "zero", "ss02", "ss03", "ss07", "ss10", "ss11", "ss13", "ss15", "ss17", "ss18" }
        }),
        font_size = 9.0,
        underline_position = "-3px",
        underline_thickness = "150%",

        -- window
        -- window_background_opacity = 0.98,
        window_background_opacity = 1.0,
        window_close_confirmation = "NeverPrompt",
        window_padding = {
          left = "4px",
          right = "4px",
          top = "4px",
          bottom = "0"
        },

        -- colors
        color_scheme = "Nord (base16)",
        colors = {
          visual_bell = "#202020",
          background = "#191c1f"
        },

        -- general styling
        default_cursor_style = "BlinkingBlock",
        enable_scroll_bar = false,
        enable_tab_bar = false,

        -- general config
        clean_exit_codes = { 130 },
        automatically_reload_config = true,
        front_end = "OpenGL",

        leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
        keys = {
          {
            key = "h",
            mods = "LEADER",
            action = wezterm.action.SplitPane({ direction = "Down", size = { Percent = 25 } })
          },
        },
      }
    '';
  };
}
