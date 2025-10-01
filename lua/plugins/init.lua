-- ----------------------------------------
--  Plugin installation
-- ----------------------------------------
local function setup()
  require("lazy").setup({
    -- UI
    { "rebelot/kanagawa.nvim" },
    { "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    { "shellRaining/hlchunk.nvim" },

    -- Git
    { "lewis6991/gitsigns.nvim" },
    { "lambdalisue/gina.vim" },

    -- Navigation & Fuzzy finding
    { "junegunn/fzf", build = ":call fzf#install()" },
    { "junegunn/fzf.vim" },
    { "yuki-yano/fuzzy-motion.vim" },
    { "stevearc/oil.nvim", opts = {} },

    -- Editing
    { "kana/vim-operator-user", lazy = false },
    { "kana/vim-operator-replace", dependencies = { "kana/vim-operator-user" } },
    { "thinca/vim-qfreplace" },
    { "cespare/vim-toml" },
    { "mattn/emmet-vim" },
    { "fuenor/JpFormat.vim" },

    -- LSP & Autocomplete
    { "neoclide/coc.nvim", branch = "release", build = "npm install" },
    { "github/copilot.vim" },

    -- Treesitter
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "nvim-treesitter/nvim-treesitter-context" },

    -- Languages
    { "leafOfTree/vim-svelte-plugin" },

    -- Misc
    { "Shougo/vimproc.vim", build = "make" },
    { "editorconfig/editorconfig-vim" },
    { "vim-denops/denops.vim" },
    { "lambdalisue/kensaku-search.vim" },
    { "lambdalisue/kensaku.vim" },

    -- mini.nvim
    { "echasnovski/mini.nvim", version = '*' },

    -- Copilot Chat dependencies
    { "zbirenbaum/copilot.lua" },
    { "nvim-lua/plenary.nvim" },
    { "CopilotC-Nvim/CopilotChat.nvim", branch = "main" },

    -- CodeCompanion.nvim (AI Coding, Vim Style)
    { "MunifTanjim/nui.nvim" },
    {
      "olimorris/codecompanion.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "MunifTanjim/nui.nvim",
      },
      config = function()
        require("plugins.codecompanion").setup()
      end,
    },
  })
end

return { setup = setup }
