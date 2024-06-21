{...}: {
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
            harfbuzz_features = { "zero", "ss02", "ss03", "ss07", "ss10", "ss11", "ss13", "ss15", "ss17", "ss18" },
        }),
        font_size = 9.0,
        use_cap_height_to_scale_fallback_fonts = true,
        underline_position = "-3px",
        underline_thickness = "150%",

        -- window
        window_background_opacity = 0.98,
        window_close_confirmation = "NeverPrompt",
        window_padding = {
          left = "4px",
          right = "4px",
          top = "4px",
          bottom = "0"
        },
        window_frame = {
          font = wezterm.font({ family = "Iosevka", weight = "Bold" }),
          font_size = 8.5,
          active_titlebar_bg = "rgba(9.8%, 11%, 12.2%, 98%)",
          inactive_titlebar_bg = "rgba(9.8%, 11%, 12.2%, 98%)",
        },

        -- colors
        color_scheme = "Nord (base16)",
        colors = {
          visual_bell = "#202020",
          background = "#191c1f",
          tab_bar = {
            inactive_tab_edge = "#191c1f",
            background = "#2e3440",
              active_tab = {
                bg_color = "#81a1c1",
                fg_color = "#2e3440",
              },
              inactive_tab = {
                bg_color = "#2e3440",
                fg_color = "#434c5e",
              },
              inactive_tab_hover = {
                bg_color = "#4c5668",
                fg_color = "#81a1c1",
              },
              new_tab = {
                bg_color = "#2e3440",
                fg_color = "#808080",
              },
          --  new_tab_hover = {},
          },
        },

        -- general styling
        default_cursor_style = "BlinkingBlock",
        enable_scroll_bar = false,
        hide_tab_bar_if_only_one_tab = true,

        -- general config
        clean_exit_codes = { 130 },
        automatically_reload_config = true,
        front_end = "WebGpu",

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
