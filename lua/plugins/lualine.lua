-- ----------------------------------------
--  Lualine plugin settings
-- ----------------------------------------
local function setup()
  require'lualine'.setup {
    options = {
      theme = "kanagawa",
      component_separators = { left = "│", right = "│" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = true,
      refresh = {
        statusline = 200,
        tabline = 200,
        winbar = 200,
      }
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = {
        { "filename", path = 1 } -- 0: Just filename, 1: Relative path, 2: Absolute path
      },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" }
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
  }
end

return { setup = setup }
