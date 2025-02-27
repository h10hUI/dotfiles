-- ----------------------------------------
--  Treesitter plugin settings
-- ----------------------------------------
local function setup()
  -- treesitterの設定
  require('nvim-treesitter.configs').setup {
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    }
  }

  -- treesitter-contextの設定
  require('treesitter-context').setup {
    enable = true,
    multiwindow = false,
    max_lines = 0,
    min_window_height = 0,
    line_numbers = true,
    multiline_threshold = 20,
    trim_scope = 'outer',
    mode = 'cursor',
    separator = nil,
    zindex = 20,
    on_attach = nil,
  }

  -- キーマッピングの設定
  vim.keymap.set("n", "[h", function()
    require("treesitter-context").go_to_context(vim.v.count1)
  end, { silent = true })
end

return { setup = setup }
