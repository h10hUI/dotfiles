require'hop'.setup {
  vim.api.nvim_set_keymap('n', '\\', '[hop]', {}),
  vim.api.nvim_set_keymap('n', '[hop]S', '<cmd>HopChar1<cr>', {}),
  vim.api.nvim_set_keymap('n', '[hop]s', '<cmd>HopChar2<cr>', {}),
  vim.api.nvim_set_keymap('n', '[hop]w', '<cmd>HopWord<cr>', {}),
  vim.api.nvim_set_keymap('n', '[hop]l', '<cmd>HopLine<cr>', {}),
  vim.api.nvim_set_keymap('n', '[hop]p', '<cmd>HopPattern<cr>', {}),
  vim.api.nvim_set_keymap('n', '[hop]P', '<cmd>HopPatternBackwards<cr>', {}),
  vim.api.nvim_set_keymap('n', '[hop]b', '<cmd>HopLineStartMW<cr>', {}),
}
