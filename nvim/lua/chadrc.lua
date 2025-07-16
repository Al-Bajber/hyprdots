-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "catppuccin",
  transparency = true,


	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

M.nvdash = {
  load_on_startup = true,
  header = {
  "           ▄ ▄                   ",
  "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
  "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
  "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
  "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
  "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
  "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
  "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
  "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
  "                                 "
  },
  buttons = {
    { txt = "  Open Folder", cmd = "lua require('custom.functions').open_folder()", keys = "o" },
    {txt = "  Create Folder", cmd = "lua require('custom.functions').create_folder()", keys = "f" },
    { txt = "  Create File", cmd = "lua require('custom.functions').create_file()", keys = "n" }
  }
}
M.ui = {
   tabufline = {
      -- enabled = false,
      enabled = true,
      overriden_modules = function(modules)
        print("Tabufline modules before:", vim.inspect(modules))
        -- remove the buttons module (4th entry)
        table.remove(modules, 4)
        print("Tabufline modules after:", vim.inspect(modules))
      end,
      lazyload = false,
   },
}

return M
