local M = {}

M.blankline = {
	-- use_treesitter = true,
	-- char_list = {"", "┊", "┆", "¦", "|", "¦", "┆", "┊", ""},
	char = "¦",
	context_char = "¦",
	-- char = "▏",
	-- context_char = "▏",
	-- show_current_context_start_on_current_line = true,
}

M.treesitter = {
	ensure_installed = {
		"html",
		"css",
		"nix",
		"hcl",
		"terraform",
		"dockerfile",
		"fish",
		"gitattributes",
		"gitignore",
		"toml",
		"json",
		"jsonc",
		"json5",
		"yaml",
		"vim",
    "vimdoc",
		"javascript",
		"typescript",
		"markdown",
		"markdown_inline",
	},
	indent = {
		enable = true,
		-- disable = {
		--   "python"
		-- },
	},
}

M.mason = {
	ensure_installed = {},
}

-- git support in nvimtree
M.nvimtree = {
	git = {
		enable = true,
	},

	renderer = {
		highlight_git = true,
		icons = {
			show = {
				git = true,
			},
		},
	},
}

return M
