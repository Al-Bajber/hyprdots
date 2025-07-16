-- ~/.config/nvim/lua/custom/configs/nvimtree.lua
-- return {
--   respect_buf_cwd = true,
--   sync_root_with_cwd = true,
--   update_focused_file = {
--     enable = true,
--     update_root = true,
--   },
-- }
-- -- In your custom nvimtree.lua (or equivalent file)
return {
  actions = {
    change_dir = {
      enable = true,  -- Enable changing the working directory when navigating the tree
      global = true,  -- Use :cd for global cwd changes (instead of :lcd)
      restrict_above_cwd = false  -- Allow navigation above the cwd in the tree
    },
  },
}

