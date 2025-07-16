-- vim.api.nvim_create_autocmd("BufReadPost", {
--   callback = function()
--     local path = vim.fn.expand("%:p:h")
--     if vim.fn.isdirectory(path) == 1 then
--       vim.cmd("cd " .. path)
--       require("nvim-tree.api").tree.change_root(vim.fn.getcwd())
--     end
--   end,
-- })
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    -- List of tabufline highlight groups to make transparent
    local groups = {
      "TbFill",
      "TbBufOn",
      "TbBufOff",
      "TbBufOnClose",
      "TbBufOffClose",
      "TbBufOnModified",
      "TbBufOffModified",
      "TbTabNewBtn",
      "TbTabOff",
      "TBTabTitle",
      "TbThemeToggleBtn",
      "TbCloseAllBufsBtn",
    }

    -- Apply transparency to each group
    for _, group in ipairs(groups) do
      vim.api.nvim_set_hl(0, group, { bg = "NONE" })
    end
  end,
})


vim.api.nvim_create_autocmd("FileType", {
  pattern = "javascript",
  callback = function(args)
    vim.bo[args.buf].filetype = "javascriptreact"
  end,
})
