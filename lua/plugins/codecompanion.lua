-- ----------------------------------------
--  CodeCompanion.nvim plugin settings
-- ----------------------------------------
local function setup()
  require("codecompanion").setup({
    strategies = {
      chat = {
        adapter = "claude",
        opts = {
          completion_provider = "coc",
        },
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
        opts = {
          on_buf_enter = function(buf)
            -- Treesitterのデコレーションエラーを抑制
            vim.api.nvim_buf_call(buf, function()
              local old_notify = vim.notify
              vim.notify = function(msg, level, opts)
                if type(msg) == "string" and msg:match("Invalid 'end_col': out of range") then
                  return
                end
                old_notify(msg, level, opts)
              end
            end)
          end,
        },
      },
    },
    slash_commands = {
      ["symbols"] = {
        opts = {
          provider = "default",
        },
      },
      ["buffer"] = {
        opts = {
          provider = "default",
        },
      },
      ["file"] = {
        opts = {
          provider = "default",
        },
      },
      ["fetch"] = {
        opts = {
          provider = "default",
        },
      },
    },
    opts = {
      log_level = "TRACE",
      system_prompt = function(opts)
        return [[You are an AI programming assistant integrated into Neovim.
You are helpful, expert programmer.
All non-code text responses must be written in Japanese language.
Keep your answers short and impersonal.]]
      end,
    },
    memory = {
      opts = {
        chat = {
          enabled = true,
        },
      },
      default = {
        description = "Project-specific AI prompt files",
        parser = "claude",
        files = {
          ".ai-prompt.md",
          "CLAUDE.md",
          "CLAUDE.local.md",
        },
      },
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

  -- fzf を使ったカスタムプロバイダーを作成
  local symbols_module = require("codecompanion.strategies.chat.slash_commands.symbols")
  local original_execute = symbols_module.execute

  -- fzf プロバイダー関数
  local function fzf_provider(SlashCommand)
    local scan = require("plenary.scandir")
    local files = scan.scan_dir(vim.fn.getcwd(), {
      hidden = true,
      depth = 10,
      add_dirs = false,
    })

    -- fzf に渡すファイルリスト
    local fzf_files = table.concat(files, "\n")

    vim.fn['fzf#run'](vim.fn['fzf#wrap']({
      source = vim.split(fzf_files, "\n"),
      sink = function(selected)
        SlashCommand:output({
          path = selected,
          relative_path = selected,
        })
      end,
      options = "--prompt='Select symbol(s): '"
    }))
  end

  symbols_module.execute = function(self, SlashCommands)
    -- fzf プロバイダーを使用
    return fzf_provider(self)
  end

  -- output を上書きして visible = true にする（バッファにも表示）
  local config = require("codecompanion.config")
  local Chat = require("codecompanion.strategies.chat")
  local original_chat_add_message = Chat.add_message

  Chat.add_message = function(self, message, options)
    -- symbols からの呼び出しの場合はバッファにも表示
    if options and options.context_id and options.context_id:match("^<symbols>") then
      local new_options = vim.tbl_extend("force", options, { visible = true })
      original_chat_add_message(self, message, new_options)
      -- バッファにも表示
      self:add_buf_message(message, new_options)
      return self
    end
    return original_chat_add_message(self, message, options)
  end

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

  -- Diff accept後にdiffウィンドウを閉じる
  vim.api.nvim_create_autocmd("User", {
    pattern = "CodeCompanionDiffAccepted",
    callback = function(event)
      vim.defer_fn(function()
        -- フローティングウィンドウを探して閉じる
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local win_config = vim.api.nvim_win_get_config(win)
          if win_config.relative ~= "" then
            vim.api.nvim_win_close(win, false)
            break
          end
        end
      end, 50)
    end,
  })
end

return { setup = setup }
