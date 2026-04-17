-- ----------------------------------------
--  Treesitter plugin settings
-- ----------------------------------------
local function setup()
  -- treesitterの設定
  require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    }
  }

  -- CodeCompanionのクエリを使えるようにruntimepathに追加
  vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/lazy/codecompanion.nvim")

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

  -- fold設定をTreesitter初期化後に設定 (Neovim 0.10+ 組み込みfoldexprを使用)
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

  -- 特定のファイルタイプでfoldingを無効化
  local disabled_ft = { json = true, yaml = true, vim = true, markdown = true }
  vim.api.nvim_create_augroup("FoldingFix", { clear = true })
  vim.api.nvim_create_autocmd({ "BufReadPost", "FileType", "BufWinEnter" }, {
    group = "FoldingFix",
    callback = function()
      if not disabled_ft[vim.bo.filetype] then
        vim.opt_local.foldmethod = "expr"
        vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      end
    end,
  })
end

return { setup = setup }
