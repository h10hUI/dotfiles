-- ----------------------------------------
--  Miscellaneous plugin settings
-- ----------------------------------------
local function setup()
  -- textobj-multiblock
  vim.keymap.set("o", "ab", "<Plug>(textobj-multiblock-a)")
  vim.keymap.set("o", "ib", "<Plug>(textobj-multiblock-i)")
  vim.keymap.set("x", "ab", "<Plug>(textobj-multiblock-a)")
  vim.keymap.set("x", "ib", "<Plug>(textobj-multiblock-i)")

  -- fuzzy-motion
  vim.keymap.set("n", "ss", ":FuzzyMotion<CR>")
  vim.g.fuzzy_motion_labels = {
    'A', 'O', 'E', 'U', 'I', 'D', 'H', 'T', 'N', 'S', 'P', 'Y', 'F', 'G', 'C', 'R', 'L', 'Q', 'J', 'K', 'X', 'B', 'M', 'W', 'V', 'Z'
  }

  -- columnskip
  vim.keymap.set({"n", "o", "x", "v"}, "\\h", "<Plug>(columnskip:nonblank:next)", { silent = true })
  vim.keymap.set({"n", "o", "x", "v"}, "\\t", "<Plug>(columnskip:nonblank:prev)", { silent = true })

  -- copilot
  vim.g.copilot_no_tab_map = true
  vim.keymap.set("i", "<C-Space>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
  vim.keymap.set("i", "<C-l>", "<Plug>(copilot-next)", { silent = true })
  vim.keymap.set("i", "<C-k>", "<Plug>(copilot-previous)", { silent = true })

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

  -- EasyAlign
  vim.keymap.set("v", "<Enter>", "<Plug>(EasyAlign)")
  vim.keymap.set("n", "ga", "<Plug>(EasyAlign)")

  -- gina
  vim.keymap.set("n", "ldo", "<Plug>(gina-diffget-l)")
  vim.keymap.set("n", "rdo", "<Plug>(gina-diffget-r)")
end

return { setup = setup }