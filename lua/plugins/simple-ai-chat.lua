-- ----------------------------------------
--  simple-ai-chat plugin settings
-- ----------------------------------------
local function setup()
  -- simple-ai-chat の設定
  require'ai-chat'.setup{
    model = "claude-sonnet-5", -- 使用するモデルを指定
  }
end

return { setup = setup }
