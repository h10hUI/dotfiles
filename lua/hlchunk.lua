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

require'hlchunk'.setup{
  indent = {},
  chunk = {
    use_treesitter = true,
    support_filetypes = common_filetypes,
    exclude_filetypes = {
      python = true,
      css = true,
      scss = true,
      html = true,
      json = true,
    },
  },
  blank = {
    enable = false,
  },
  line_num = {
    support_filetypes = common_filetypes,
  },
}
