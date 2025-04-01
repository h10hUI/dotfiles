-- ----------------------------------------
--  FZF settings
-- ----------------------------------------
local function setup()
  vim.opt.rtp:append("/opt/homebrew/opt/fzf")
  vim.keymap.set("n", ":", ":Buffers<CR>'", { silent = true })
  vim.keymap.set("n", "q:", ":History:<CR>'", { silent = true })
  vim.keymap.set("n", "<Leader>?", ":GFiles?<CR>'", { silent = true })
  vim.keymap.set("n", "<Leader>u", ":GFiles<CR>'", { silent = true })
  vim.keymap.set("n", "<Leader>d", ":History<CR>'", { silent = true })
  vim.keymap.set("n", "<Leader>r", ":Tags<CR>", { silent = true })

  -- FZF completion keymaps
  vim.keymap.set("i", "<C-x><C-k>", "<Plug>(fzf-complete-word)")
  vim.keymap.set("i", "<C-x><C-f>", "<Plug>(fzf-complete-path)")
  vim.keymap.set("i", "<C-x><C-j>", "<Plug>(fzf-complete-file-ag)")
  vim.keymap.set("i", "<C-x><C-l>", "<Plug>(fzf-complete-line)")

  vim.g.fzf_preview_window = ''
  vim.g.fzf_buffers_jump = 1
  vim.g.fzf_layout = { down = '40%' }
end

return { setup = setup }
