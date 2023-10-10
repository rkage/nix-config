local wezterm = require("wezterm")
local mux = wezterm.mux

local config = {}

-- bell
config.audible_bell = "Disabled"
config.visual_bell = {
  fade_in_function = "EaseIn",
  fade_in_duration_ms = 100,
  fade_out_function = "EaseOut",
  fade_out_duration_ms = 100,
}

-- font
config.font = wezterm.font({
  family = "MonoLisa",
  -- weight = "Regular",
  harfbuzz_features = { "zero", "ss06", "ss07", "ss10", "ss11" },
})
config.font_size = 9.0
config.underline_position = "-3px"
config.underline_thickness = "150%"

-- window
config.window_background_opacity = 0.95
config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
	left = "5px",
	right = "5px",
	top = "0",
	bottom = "0",
}

-- colors
config.color_scheme = "Nord (base16)"
config.colors = {
	background = "#191c1f",
	-- tab_bar = {
	-- 	active_tab = {
	-- 		bg_color = "#191c1f",
	-- 		fg_color = "#d8dee9",
	-- 	},
	-- 	inactive_tab = {
	-- 		bg_color = "#1f1f1f",
	-- 		fg_color = "#808080",
	-- 	},
	-- 	inactive_tab_edge = "#1f1f1f",
	-- },
}

-- general styling
config.default_cursor_style = "BlinkingBlock"
config.enable_scroll_bar = false
config.enable_tab_bar = false

-- general config
config.clean_exit_codes = { 130 }
config.automatically_reload_config = true
-- config.front_end = "OpenGL"

return config
