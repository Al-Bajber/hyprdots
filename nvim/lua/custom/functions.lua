local M = {}

function M.open_folder()
  require("yazi").yazi({
    select = true,              -- Set true if you want to select a file/folder on open
    path = vim.fn.getcwd(), -- You can change this path as needed
  })
end


function M.create_folder()
  vim.ui.input({ prompt = "New folder name: " }, function(input)
    if input and input ~= "" then
      local folder_path = vim.fn.expand("~/Desktop/Projects/" .. input)
      os.execute("mkdir -p " .. folder_path)
      print("✅ Folder created: " .. folder_path)

      -- Use NvimTree API to open the folder
      vim.cmd("cd " .. folder_path)
      require("nvim-tree.api").tree.open()
    end
  end)
end

function M.create_file()
  vim.ui.input({ prompt = "New file name: " }, function(input)
    if input and input ~= "" then
      local filepath = "~/Desktop/Projects/" .. input
      vim.cmd("edit " .. filepath)
    end
  end)
end

return M
