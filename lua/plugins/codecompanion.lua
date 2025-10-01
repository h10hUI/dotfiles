-- ----------------------------------------
--  CodeCompanion.nvim plugin settings
-- ----------------------------------------
local function setup()
  require("codecompanion").setup({
    strategies = {
      chat = {
        adapter = "claude",
      },
      inline = {
        adapter = "claude",
      },
      agent = {
        adapter = "claude",
      },
    },
    adapters = {
      http = {
        claude = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "ANTHROPIC_API_KEY",
            },
            schema = {
              model = {
                default = "claude-4-sonnet-20250514",
              },
              max_tokens = {
                default = 2048,
              },
              temperature = {
                default = 0,
              },
            },
          })
        end,
      },
    },
    display = {
      diff = {
        provider = "mini_diff",
      },
      chat = {
        window = {
          layout = "vertical",
          width = 0.4,
        },
      },
    },
    opts = {
      log_level = "ERROR",
      system_prompt = function(opts)
        return [[You are an AI programming assistant integrated into Neovim.
You are helpful, expert programmer.
All non-code text responses must be written in Japanese language.
Keep your answers short and impersonal.]]
      end,
    },
    tools = {
      web_search = {
        enabled = true,
        provider = "tavily",
        env = {
          api_key = "TAVILY_API_KEY",
        },
      },
    },
  })

  -- キーマッピング設定（<leader>a* で統一）
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- チャット
  keymap("n", "<leader>aa", ":CodeCompanionChat<CR>", vim.tbl_extend("force", opts, { desc = "CodeCompanion: Open Chat" }))
  keymap("v", "<leader>aa", ":CodeCompanionChat<CR>", vim.tbl_extend("force", opts, { desc = "CodeCompanion: Chat with selection" }))

  -- インラインアシスタント
  keymap("n", "<leader>ai", ":CodeCompanion<CR>", vim.tbl_extend("force", opts, { desc = "CodeCompanion: Inline assistant" }))
  keymap("v", "<leader>ai", ":CodeCompanion<CR>", vim.tbl_extend("force", opts, { desc = "CodeCompanion: Inline with selection" }))

  -- アクション
  keymap("n", "<leader>ac", ":CodeCompanionActions<CR>", vim.tbl_extend("force", opts, { desc = "CodeCompanion: Actions" }))
  keymap("v", "<leader>ac", ":CodeCompanionActions<CR>", vim.tbl_extend("force", opts, { desc = "CodeCompanion: Actions with selection" }))

  -- トグル
  keymap("n", "<leader>at", ":CodeCompanionChat Toggle<CR>", vim.tbl_extend("force", opts, { desc = "CodeCompanion: Toggle Chat" }))

  -- クイックチャット（カスタムプロンプト）
  keymap("n", "<leader>aq", function()
    local input = vim.fn.input("Quick question: ")
    if input ~= "" then
      vim.cmd("CodeCompanionChat " .. input)
    end
  end, vim.tbl_extend("force", opts, { desc = "CodeCompanion: Quick question" }))
end

return { setup = setup }