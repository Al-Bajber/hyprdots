require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
-- -- Yazi integration
map("n", "<leader>fy", function()
  require("yazi").yazi()
end, { desc = "Open Yazi File Manager" })

-- Yank to system clipboard in normal mode
map("n", "y", '"+y', { desc = "Yank to system clipboard" })
map("n", "yy", '"+yy', { desc = "Yank line to system clipboard" })

-- Yank to system clipboard in visual mode
map("v", "y", '"+y', { desc = "Yank selection to system clipboard" })
