-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
	Normal = { bg = "NONE" },
	NvimTreeNormal = {
		bg = "#1e222a",
	},
	NvimTreeNormalNC = {
		bg = "#1e222a",
	},
	NvimTreeWinSeparator = {
		bg = "#1e222a",
		fg = "#1e222a",
	},
	Comment = {
		italic = true,
	},
	IndentBlanklineChar = {
		fg = "#252931",
	},
	IndentBlanklineContextChar = {
		fg = "#252931",
	},
	IndentBlanklineContextStart = {
		bg = "#252931",
		-- underline = true,
	},
}

---@type HLTable
M.add = {
	NvimTreeOpenedFolderName = { fg = "green", bold = true },
}

return M
