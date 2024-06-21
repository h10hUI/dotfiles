local common_filetypes = {
  "*.lua",
  "*.js",
  "*.ts",
  "*.svelte",
  "*.astro",
  "*.jsx",
  "*.tsx",
  "*.rb",
  "*.css",
  "*.scss",
}

local color = "#806d9c"

require 'hlchunk'.setup {
  indent = {
    enable = true,
  },
  chunk = {
    enable = true,
    support_filetypes = common_filetypes,
    exclude_filetypes = {
      python = true,
      css = true,
      scss = true,
      html = true,
      json = true,
    },
    chars = {
      left_arrow = "",
      horizontal_line = "─",
      vertical_line = "│",
      left_top = "╭",
      left_bottom = "╰",
      right_arrow = "",
    },
    style = {
      { fg = color },
      { fg = "#c21f30" }, -- This fg is used to highlight wrong chunk
    },
    delay = 100,
  },
  blank = {
    enable = false,
  },
  line_num = {
    enable = true,
    support_filetypes = common_filetypes,
    style = color,
  },
}
