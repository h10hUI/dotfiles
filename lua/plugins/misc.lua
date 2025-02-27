-- ----------------------------------------
--  Miscellaneous plugin settings
-- ----------------------------------------
local function setup()
  -- fuzzy-motion
  vim.keymap.set("n", "ss", ":FuzzyMotion<CR>")
  vim.g.fuzzy_motion_labels = {
    'A', 'O', 'E', 'U', 'I', 'D', 'H', 'T', 'N', 'S', 'P', 'Y', 'F', 'G', 'C', 'R', 'L', 'Q', 'J', 'K', 'X', 'B', 'M', 'W', 'V', 'Z'
  }

  -- copilot
  vim.g.copilot_no_tab_map = true
  vim.keymap.set("i", "<C-Space>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
  vim.keymap.set("i", "<C-l>", "<Plug>(copilot-next)", { silent = true })
  vim.keymap.set("i", "<C-k>", "<Plug>(copilot-previous)", { silent = true })
  vim.keymap.set("i", "<C-u>", "<Plug>(copilot-dismiss)", { silent = true })

  -- emmet
  vim.g.user_emmet_install_global = 0
  vim.api.nvim_create_autocmd("FileType", {
    pattern = {"html", "css", "php", "markdown", "javascript", "javascriptreact", "typescriptreact", "eruby", "astro"},
    command = "EmmetInstall"
  })

  -- kensaku-search
  vim.keymap.set("c", "<CR>", "<Plug>(kensaku-search-replace)<CR>")

  -- operator-replace
  vim.keymap.set("n", "^", "<Plug>(operator-replace)")

  -- JpFormat
  vim.keymap.set("n", "gL", ":JpFormatAll<CR>")
  vim.g.JpFormatMarker = "  "

  -- gina
  vim.keymap.set("n", "ldo", "<Plug>(gina-diffget-l)")
  vim.keymap.set("n", "rdo", "<Plug>(gina-diffget-r)")
end

return { setup = setup }
