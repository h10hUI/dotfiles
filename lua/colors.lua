-- ----------------------------------------
--  Color settings
-- ----------------------------------------
local function setup()
  vim.cmd("set t_Co=256")
  vim.cmd("syntax on")
  vim.g.nvcode_termcolors = 256
  vim.cmd("hi clear")
  vim.cmd("colorscheme kanagawa")
  vim.opt.cursorline = true
end

return { setup = setup }