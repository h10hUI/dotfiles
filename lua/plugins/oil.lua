-- ----------------------------------------
--  Oil plugin settings
-- ----------------------------------------
local function setup()
  -- oil.nvimの設定
  require('oil').setup()
  
  -- キーマッピングの設定
  vim.api.nvim_set_keymap("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
end

return { setup = setup }