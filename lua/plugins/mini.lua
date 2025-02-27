-- ----------------------------------------
--  mini.nvim plugin settings
-- ----------------------------------------
local function setup()
  -- mini.ai - テキストオブジェクト拡張
  require("mini.ai").setup({
    n_lines = 500,
    custom_textobjects = {
      -- 関数のパラメータオブジェクト
      P = { '()', '[]', '{}' },
    },
  })

  -- mini.surround - サラウンド操作
  require("mini.surround").setup({
    -- 入力マッピングのキー
    mappings = {
      add = "sa",            -- サラウンド追加
      delete = "sd",         -- サラウンド削除
      find = "sf",           -- サラウンド検索
      find_left = "sF",      -- 左側のサラウンド検索
      highlight = "sh",      -- サラウンドハイライト
      replace = "sr",        -- サラウンド置換
      update_n_lines = "sn", -- 対象行数の更新
    },
  })

  -- mini.align - テキスト整列
  require("mini.align").setup({
    -- アライメント設定
    mappings = {
      start = "ga",        -- アラインメント開始
      start_with_preview = "gA", -- プレビュー付きアラインメント開始
    },
    -- デフォルトのオプション
    options = {
      split_pattern = "",  -- スプリットパターン
      justify_side = "left", -- 位置合わせ方向
      merge_delimiter = "",  -- マージ区切り文字
    },
    -- ステップ設定（パターン列の位置合わせなど）
    steps = {
      pre_split = {},
      split = nil,
      pre_justify = {},
      justify = nil,
      pre_merge = {},
      merge = nil,
    },
  })

  -- mini.jump2d - 2D移動
  local jump2d = require("mini.jump2d")

  -- ビルトインの1文字マッチを使用するシンプルな設定
  jump2d.setup({
    -- 移動設定
    mappings = {
      start_jumping = "\\\\", -- 移動開始（バックスラッシュ2回）
    },
    -- 表示設定
    view = {
      dim = true,         -- 非ターゲット部分を暗くする
      n_steps_ahead = 0,  -- 表示ステップ数
    },
    -- ラベル文字列（変形Dvorak配列に最適化された文字列）
    labels = "iueoadhtnsypfgcrlxkjqbmwvz'",
  })

  -- カスタム2文字マッチジャンプのためのコマンド
  vim.api.nvim_create_user_command('Jump2Char2', function()
    -- 組み込みの文字列マッチを使用
    jump2d.start(jump2d.builtin_opts.query)
  end, {})

  -- 2文字マッチ用のキーマッピング
  vim.api.nvim_set_keymap('n', '\\s', '<cmd>Jump2Char2<cr>', {})
end

return { setup = setup }
