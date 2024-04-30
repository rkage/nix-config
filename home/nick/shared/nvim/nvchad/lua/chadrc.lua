-- This file  needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "onenord",

  transparency = false,

  hl_override = {
    Normal = { bg = "NONE" },
    -- NvimTreeNormal = {
    --   bg = "#1e222a"
    -- },
    -- NvimTreeNormalNC = {
    --   bg = "#1e222a"
    -- },
    -- NvimTreeWinSeparator = {
    --   fg = "#1e222a",
    --   bg = "NONE",
    -- },
    -- CursorLine = {
    --   bg = 'black2',
    -- },
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    -- IndentBlanklineChar = {
    --   fg = "#252931"
    -- },
    -- IndentBlanklineContextStart = {
    --   bg = "#252931"
    -- }
  },
}

return M
