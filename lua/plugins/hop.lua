-- ----------------------------------------
--  Hop plugin settings
-- ----------------------------------------
local function setup()
  -- hopの設定
  require('hop').setup()

  -- キーマッピングの設定
  vim.api.nvim_set_keymap('n', '\\S', '<cmd>HopChar1<cr>', {})
  vim.api.nvim_set_keymap('n', '\\s', '<cmd>HopChar2<cr>', {})
  vim.api.nvim_set_keymap('n', '\\w', '<cmd>HopWord<cr>', {})
  vim.api.nvim_set_keymap('n', '\\l', '<cmd>HopLine<cr>', {})
  vim.api.nvim_set_keymap('n', '\\p', '<cmd>HopPattern<cr>', {})
  vim.api.nvim_set_keymap('n', '\\P', '<cmd>HopPatternBackwards<cr>', {})
  vim.api.nvim_set_keymap('n', '\\b', '<cmd>HopLineStartMW<cr>', {})
end

return { setup = setup }
