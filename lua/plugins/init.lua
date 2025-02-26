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
    { "phaazon/hop.nvim", config = true },
    { "yuki-yano/fuzzy-motion.vim" },
    { "stevearc/oil.nvim", opts = {} },

    -- Editing
    { "junegunn/vim-easy-align" },
    { "kana/vim-textobj-user", lazy = false },
    { "kana/vim-operator-user", lazy = false },
    { "kana/vim-operator-replace", dependencies = { "kana/vim-operator-user" } },
    { "osyo-manga/vim-textobj-multiblock", dependencies = { "kana/vim-textobj-user" } },
    { "machakann/vim-sandwich" },
    { "tyru/columnskip.vim" },
    { "thinca/vim-qfreplace" },
    { "cespare/vim-toml" },
    { "mattn/emmet-vim" },
    { "fuenor/JpFormat.vim" },

    -- LSP & Autocomplete
    { "neoclide/coc.nvim", branch = "release", build = "npm install" },
    { "hrsh7th/vim-eft" },
    { "github/copilot.vim" },
    { "yaegassy/coc-astro", build = "yarn install --immutable" },

    -- Treesitter
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "nvim-treesitter/nvim-treesitter-context" },

    -- Languages
    { "leafOfTree/vim-svelte-plugin" },

    -- Misc
    { "Shougo/vimproc.vim", build = "make" },
    { "editorconfig/editorconfig-vim" },
    { "rking/ag.vim" },
    { "vim-denops/denops.vim" },
    { "lambdalisue/kensaku-search.vim" },
    { "lambdalisue/kensaku.vim" },

    -- Copilot Chat dependencies
    { "zbirenbaum/copilot.lua" },
    { "nvim-lua/plenary.nvim" },
    { "CopilotC-Nvim/CopilotChat.nvim", branch = "main" },
  })
end

return { setup = setup }