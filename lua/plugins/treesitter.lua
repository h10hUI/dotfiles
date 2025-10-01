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

  -- fold設定をTreesitter初期化後に設定
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

  -- 特定のファイルタイプでfoldingを無効化
  vim.cmd([[
    let g:folding_disabled_filetypes = ['json', 'yaml', 'vim', 'markdown']

    function! ResetFoldSettings(...)
      if index(g:folding_disabled_filetypes, &filetype) == -1
        if exists('*nvim_treesitter#foldexpr')
          set foldmethod=expr
          set foldexpr=nvim_treesitter#foldexpr()
        endif
      endif
    endfunction

    augroup FoldingFix
      autocmd!
      autocmd BufReadPost * call timer_start(1, 'ResetFoldSettings') | call timer_start(50, 'ResetFoldSettings') | call timer_start(100, 'ResetFoldSettings')
      autocmd FileType * call timer_start(1, 'ResetFoldSettings') | call timer_start(50, 'ResetFoldSettings')
      autocmd BufWinEnter * call timer_start(1, 'ResetFoldSettings')
      autocmd CursorHold,CursorHoldI * call ResetFoldSettings()
    augroup END
  ]])
end

return { setup = setup }
