-- ----------------------------------------
--  Avante.nvim plugin settings
-- ----------------------------------------
local function setup()
  require('avante').setup({
    provider = "claude",
    auto_suggestions = true,
    providers = {
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-4-sonnet-20250514",
        extra_request_body = {
          temperature = 0,
          max_tokens = 4096,
        },
      },
    },
    behaviour = {
      auto_suggestions = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
    },
    ui = {
      input = {
        provider = "native",
        opts = {
          relative = "cursor",
        },
      },
    },
    mappings = {
      diff = {
        ours = "co",
        theirs = "ct",
        all_theirs = "ca",
        both = "cb",
        cursor = "cc",
        next = "]x",
        prev = "[x",
      },
      suggestion = {
        accept = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
      jump = {
        next = "]]",
        prev = "[[",
      },
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
      sidebar = {
        apply_all = "A",
        apply_cursor = "a",
        switch_windows = "<Tab>",
        reverse_switch_windows = "<S-Tab>",
      },
    },
    hints = { enabled = true },
    windows = {
      position = "right",
      wrap = true,
      width = 45,
      sidebar_header = {
        enabled = false,
        -- align = "center",
        -- rounded = true,
      },
      input = {
        prefix = "> ",
        height = 8,
      },
      edit = {
        -- border = "rounded",
        start_insert = true,
      },
      ask = {
        floating = false,
        start_insert = true,
        -- border = "rounded",
        focus_on_apply = "ours",
      },
    },
    highlights = {
      diff = {
        current = "DiffText",
        incoming = "DiffAdd",
      },
    },
    diff = {
      autojump = true,
      list_opener = "copen",
    },
  })

  -- キーマッピング設定（<leader>a* で統一、競合回避）
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- メイン機能
  keymap("n", "<leader>aa", ":AvanteAsk<CR>", vim.tbl_extend("force", opts, { desc = "Avante: Ask" }))
  keymap("v", "<leader>aa", ":AvanteAsk<CR>", vim.tbl_extend("force", opts, { desc = "Avante: Ask with selection" }))

  keymap("n", "<leader>ar", ":AvanteRefresh<CR>", vim.tbl_extend("force", opts, { desc = "Avante: Refresh" }))
  keymap("n", "<leader>af", ":AvanteFocus<CR>", vim.tbl_extend("force", opts, { desc = "Avante: Focus" }))

  -- 編集・適用
  keymap("n", "<leader>ae", ":AvanteEdit<CR>", vim.tbl_extend("force", opts, { desc = "Avante: Edit" }))
  keymap("v", "<leader>ae", ":AvanteEdit<CR>", vim.tbl_extend("force", opts, { desc = "Avante: Edit with selection" }))

  -- チャット・トグル
  keymap("n", "<leader>at", ":AvanteToggle<CR>", vim.tbl_extend("force", opts, { desc = "Avante: Toggle" }))
  keymap("n", "<leader>ac", ":AvanteChat<CR>", vim.tbl_extend("force", opts, { desc = "Avante: Chat" }))

  -- その他
  keymap("n", "<leader>as", ":AvanteSwitchProvider<CR>", vim.tbl_extend("force", opts, { desc = "Avante: Switch Provider" }))
  keymap("n", "<leader>al", ":AvanteShowRepoMap<CR>", vim.tbl_extend("force", opts, { desc = "Avante: Show Repo Map" }))
end

return { setup = setup }
