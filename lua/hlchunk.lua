local common_filetypes = {
  "*.lua",
  "*.js",
  "*.ts",
  "*.svelte",
  "*.astro",
  "*.css",
  "*.jsx",
  "*.tsx",
  "*.rb",
}

require'hlchunk'.setup{
  indent = {},
  chunk = {
    support_filetypes = common_filetypes,
  },
  blank = {
    enable = false,
  },
  line_num = {
    support_filetypes = common_filetypes,
  },
}
