-- ----------------------------------------
--  CopilotChat plugin settings
-- ----------------------------------------
local function setup()
  local copilotChat = require('CopilotChat')
  local copilotChatSelect = require('CopilotChat.select')

  local function selectStagedDiff(source)
    return copilotChatSelect.git_diff(source, true)
  end

  local prompts = {
    Explain = {
      prompt = "/COPILOT_EXPLAIN 上記のコードを日本語で説明してください",
      mapping = '<leader>ce',
      description = "バディにコードの説明をお願いする",
    },
    Review = {
      prompt = '/COPILOT_REVIEW 選択したコードをレビューしてください。レビューコメントは日本語でお願いします。',
      mapping = '<leader>cr',
      description = "バディにコードのレビューをお願いする",
    },
    Fix = {
      prompt = "/COPILOT_FIX このコードには問題があります。バグを修正したコードを表示してください。説明は日本語でお願いします。",
      mapping = '<leader>cf',
      description = "バディにコードの修正をお願いする",
    },
    Optimize = {
      prompt = "/COPILOT_REFACTOR 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。説明は日本語でお願いします。",
      mapping = '<leader>co',
      description = "バディにコードの最適化をお願いする",
    },
    Docs = {
      prompt = "/COPILOT_GENERATE 選択されたコードに対して、実装に既に定義されている型情報を除外したドキュメンテーションコメントを英語で生成してください。記法は JSDoc に従ってください。",
      mapping = '<leader>cd',
      description = "バディにコードのドキュメント作りをお願いする",
    },
    Tests = {
      prompt = "/COPILOT_TESTS 選択したコードの詳細なユニットテストを書いてください。説明は日本語でお願いします。",
      mapping = '<leader>ct',
      description = "バディにコードのテストコード作成をお願いする",
    },
    FixDiagnostic = {
      prompt = 'コードの診断結果に従って問題を修正してください。修正内容の説明は日本語でお願いします。',
      mapping = '<leader>cD',
      description = "バディにコードの静的解析結果に基づいた修正をお願いする",
      selection = copilotChatSelect.diagnostics,
    },
    Commit = {
      prompt = [[
        commitize の規則に従って、変更に対するコミットメッセージを記述してください。
        タイトルは最大50文字で、タイトルのみ表示してください。メッセージは英語でお願いします。
        余計なコードの解析やアドバイス、説明は絶対にしないでください。
      ]],
      mapping = '<leader>cc',
      description = "バディにコミットメッセージの作成をお願いする",
      selection = copilotChatSelect.gitdiff,
    },
    CommitStaged = {
      prompt = [[
        commitize の規則に従って、ステージ済みの変更に対するコミットメッセージを記述してください。
        タイトルは最大50文字で、タイトルのみ表示してください。メッセージは英語でお願いします。
      ]],
      mapping = '<leader>cs',
      description = "バディにステージ済みのコミットメッセージの作成をお願いする",
      selection = selectStagedDiff,
    }
  }

  copilotChat.setup({
    show_help = "yes",
    prompts = prompts,
  })

  -- Quick chat with Copilot
  vim.keymap.set('n', '<leader>ccq', function()
    -- Select entire buffer
    vim.cmd('normal! ggVG')
    local userInput = vim.fn.input("Quick Chat: ")
    if userInput ~= "" then
      copilotChat.ask(userInput)
    end
  end, { desc = "CopilotChat - Quick chat" })
end

return { setup = setup }
