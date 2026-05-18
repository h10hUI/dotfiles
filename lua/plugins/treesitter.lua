-- ----------------------------------------
--  Treesitter plugin settings
--  Neovim 0.12+ core treesitter を使用 (nvim-treesitter は廃止)
-- ----------------------------------------
local function setup()
  -- parser管理 (tree-sitter CLIでローカルコンパイル)
  require'tree-sitter-manager'.setup {
    ensure_installed = {
      "tsx", "typescript", "javascript",
      "json", "yaml", "toml",
      "bash", "html", "css",
      "svelte", "python", "go", "rust",
    },
    auto_install = false,
  }

  -- treesitter-contextの設定
  require'treesitter-context'.setup {
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
    require'treesitter-context'.go_to_context(vim.v.count1)
  end, { silent = true })

  -- fold設定 (Neovim 0.10+ 組み込みfoldexprを使用)
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

  -- 特定のファイルタイプでfoldingを無効化
  local disabled_ft = { json = true, yaml = true, vim = true, markdown = true }

  -- core treesitterを明示的にアタッチ (旧 nvim-treesitter の highlight.enable = true 相当)
  -- parser が未インストールなら pcall で握りつぶす
  vim.api.nvim_create_augroup("TSAttach", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = "TSAttach",
    callback = function(args)
      local ft = args.match
      local lang = vim.treesitter.language.get_lang(ft) or ft
      pcall(vim.treesitter.start, args.buf, lang)

      if not disabled_ft[ft] then
        vim.opt_local.foldmethod = "expr"
        vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      end
    end,
  })
end

return { setup = setup }
