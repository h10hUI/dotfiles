-- ----------------------------------------
--  simple-ai-chat plugin settings
-- ----------------------------------------
local function setup()
  -- simple-ai-chat の設定（コメントアウト部分はデフォルト値）
  require'ai-chat'.setup{
    model = "deepseek-flash", -- 使用するモデルを指定（デフォルト: "claude-sonnet-4-6"）
    max_tokens = 50000,      -- 1 回の応答の最大トークン数
    -- deno_script = nil,      -- Deno スクリプトのパス（nil ならプラグイン同梱の deno/main.ts）

    -- model 名が match（Lua パターン）にマッチしたら、その接続先を使う。
    -- どれにもマッチしなければ Anthropic。先頭から評価して最初にマッチしたものを採用。
    -- API キーは環境変数 DEEPSEEK_API_KEY から読む。
    providers = {
      {
        match = "^deepseek",
        base_url = "https://api.deepseek.com/anthropic",
        api_key_env = "DEEPSEEK_API_KEY",
      },
    },

    -- window = {
    --   width = 0.4,          -- チャットウィンドウの幅（画面幅に対する割合）
    --   input_height = 5,     -- 入力ペインの高さ（行数）
    --   side = "left",        -- 表示位置
    -- },
  }
end

return { setup = setup }
