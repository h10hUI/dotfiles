--  |    _)  _ \___  |_ |_ |
--  __ \  | |   |   /   |  |
--  | | | | |   |  /    |  |
-- _| |_|_|\___/ _/    _| _|

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ----------------------------------------
--  Basic Settings
-- ----------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.yankring_clipboard_monitor = 0

vim.opt.ambiwidth = "double"
vim.opt.backspace = "indent,eol,start"
vim.opt.clipboard = "unnamed"
vim.opt.cmdheight = 1
vim.opt.diffopt:append("vertical")
vim.opt.display = "lastline"
vim.opt.expandtab = true
vim.opt.fileencodings = "utf-8,sjis,euc-jp"
vim.opt.foldclose = "all"
vim.opt.foldcolumn = "1"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.foldopen = "all"
vim.opt.formatoptions:append("mMj")
vim.opt.hidden = true
vim.opt.history = 1000
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.incsearch = true
vim.opt.laststatus = 2
vim.opt.lazyredraw = true
vim.opt.matchtime = 1
vim.opt.modeline = true
vim.opt.modifiable = true
vim.opt.mouse = ""
vim.opt.nrformats:remove("octal")
vim.opt.number = true
vim.opt.pumblend = 30
vim.opt.pumheight = 10
vim.opt.ruler = true
vim.opt.shiftwidth = 2
vim.opt.shortmess:append("c")
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.scrolloff = 3
vim.opt.spelllang:append("cjk")
vim.opt.tabstop = 2
vim.opt.textwidth = 0
vim.opt.title = true
vim.opt.timeoutlen = 500
vim.opt.updatetime = 250
vim.opt.virtualedit = "all"
vim.opt.visualbell = true
vim.opt.wildchar = 9 -- ASCII <Tab>
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wrap = true
vim.opt.wrapscan = true

-- ripgrep
if vim.fn.executable('rg') == 1 then
  vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
  vim.opt.grepformat = "%f:%l:%c:%m"
end

-- breakindent設定
if vim.fn.exists('+breakindent') == 1 then
  vim.opt.breakindent = true
end

-- backupファイルとスワップファイルの設定
vim.opt.backup = true
vim.opt.backupdir = vim.fn.expand("~/.config/nvim/backup")
vim.opt.swapfile = true
vim.opt.directory = vim.fn.expand("~/.config/nvim/swap")
vim.opt.backupskip = "/tmp/*,/private/tmp/*"

-- undo記憶、undoファイルの生成
if vim.fn.has('persistent_undo') == 1 then
  vim.opt.undodir = vim.fn.expand("~/.config/nvim/undo")
  vim.opt.undofile = true
end

-- foldtextの設定
vim.opt.foldtext = "v:folddashes.substitute(getline(v:foldstart),'/\\*\\|\\*/\\|{{{\\d\\=','','')"

-- Prepend mise shims to PATH
vim.env.PATH = vim.fn.expand("$HOME/.local/share/mise/shims") .. ":" .. vim.env.PATH

-- ----------------------------------------
--  Helper Functions
-- ----------------------------------------
-- 保存時に行末の空白を除去する
local remove_dust = function()
  local cursor = vim.fn.getpos(".")
  vim.cmd([[%s/\s\+$//ge]])
  vim.fn.setpos(".", cursor)
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype ~= "markdown" then
      remove_dust()
    end
  end
})

-- 全角スペースの設定
local function zenkaku_space()
  vim.cmd([[highlight ZenkakuSpace cterm=reverse ctermfg=darkgray gui=reverse guifg=darkgray]])
end

if vim.fn.has('syntax') == 1 then
  vim.api.nvim_create_augroup("ZenkakuSpace", { clear = true })
  vim.api.nvim_create_autocmd({"ColorScheme"}, {
    group = "ZenkakuSpace",
    callback = zenkaku_space
  })
  vim.api.nvim_create_autocmd({"VimEnter", "WinEnter"}, {
    group = "ZenkakuSpace",
    command = "match ZenkakuSpace /　/"
  })
  zenkaku_space()
end

-- visual モードの時にスターで選択位置のコードを検索するようにする
function _G.v_set_search()
  local temp = vim.fn.getreg("s")
  vim.cmd('normal! gv"sy')
  vim.fn.setreg("/", "\\V" .. vim.fn.substitute(vim.fn.escape(vim.fn.getreg("s"), "/\\"), "\\n", "\\\\n", "g"))
  vim.fn.setreg("s", temp)
end

vim.keymap.set("x", "*", ":call v:lua.v_set_search()<CR>/<C-R>=@/<CR><CR>", { silent = true })
vim.keymap.set("x", "#", ":call v:lua.v_set_search()<CR>?<C-R>=@/<CR><CR>", { silent = true })

-- Floating windowにフォーカスを当てる
if vim.fn.has('nvim') == 1 then
  function _G.focus_floating()
    if vim.fn.empty(vim.api.nvim_win_get_config(vim.fn.win_getid()).relative) == 0 then
      vim.cmd('wincmd p')
      return
    end

    for i = 1, vim.fn.winnr('$') do
      local winid = vim.fn.win_getid(i)
      local conf = vim.api.nvim_win_get_config(winid)
      if conf.focusable and vim.fn.empty(conf.relative) == 0 then
        vim.fn.win_gotoid(winid)
        return
      end
    end

    vim.cmd('wincmd w')
  end

  vim.keymap.set("n", "<C-w><C-w>", ":lua focus_floating()<CR>", { silent = true })
end

-- ----------------------------------------
--  Plugin installation
-- ----------------------------------------
require("lazy").setup({
  -- UI
  { "rebelot/kanagawa.nvim" },
  { "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup(require("lua.lualine"))
    end
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

-- ----------------------------------------
--  key mappings
-- ----------------------------------------
vim.keymap.set("n", "s", "<Nop>")
vim.keymap.set("n", " ", "<Nop>")

-- スペースキー + . で.vimrcを開く
vim.keymap.set("n", "<Leader>.", ":tabedit ~/.config/nvim/init.lua<CR>")

-- 検索語が画面の真ん中に来るようにする
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "*", "*zzN")
vim.keymap.set("n", "#", "#zz")
vim.keymap.set("n", "g*", "g*zz")
vim.keymap.set("n", "g#", "g#zz")

-- insertモードから抜ける
vim.keymap.set("i", "<C-j>", "<ESC>", { silent = true })

-- terminalモードから抜ける
vim.keymap.set("t", "jj", "<C-\\><C-n>", { silent = true })

-- カーソル操作
vim.keymap.set("i", "<C-a>", "<Home>")
vim.keymap.set("i", "<C-e>", "<End>")
vim.keymap.set("i", "<C-f>", "<Right>")
vim.keymap.set("i", "<C-b>", "<Left>")

-- 移動を表示行単位に
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "gj", "j")
vim.keymap.set("n", "gk", "k")

-- 現在行を入れ替える
vim.keymap.set("n", "[.", function() vim.cmd("execute 'move -1-'. v:count1") end)
vim.keymap.set("n", "].", function() vim.cmd("execute 'move +'. v:count1") end)

-- insertモードで次の行に直接改行
vim.keymap.set("i", "<C-o>", "<Esc>o")

-- cntrl + n キーで改行
vim.keymap.set("n", "<C-n>", "o<Esc>")

-- カーソルキーでバッファのサイズ変更
vim.keymap.set("n", "<Down>", "<C-w>-", { silent = true })
vim.keymap.set("n", "<Up>", "<C-w>+", { silent = true })
vim.keymap.set("n", "<Left>", "<C-w><", { silent = true })
vim.keymap.set("n", "<Right>", "<C-w>>", { silent = true })

-- ファイル操作
vim.keymap.set("n", "<Leader>,", ":w<CR>")

-- キー入れ替え
vim.keymap.set("n", ";", ":")
vim.keymap.set("n", ":", ";")

-- x の挙動
vim.keymap.set("n", "x", '"_d')
vim.keymap.set("n", "X", '"_D')
vim.keymap.set("x", "x", '"_d')
vim.keymap.set("o", "x", "d")

-- cc の挙動
vim.keymap.set("n", "cc", '"_cc')

-- i<space> の設定
vim.keymap.set("o", "i<space>", "iW")
vim.keymap.set("x", "i<space>", "iW")

-- redo
vim.keymap.set("n", "U", "<C-r>", { silent = true })

-- copy の挙動
vim.keymap.set("x", "y", "mzy`z")

-- 空行編集時の挙動
local function handle_empty_line(action)
  return function()
    if vim.fn.empty(vim.fn.getline('.')) == 1 then
      return '"_cc'
    else
      return action
    end
  end
end

vim.keymap.set("n", "i", handle_empty_line('i'), { expr = true })
vim.keymap.set("n", "A", handle_empty_line('A'), { expr = true })

-- 大文字小文字の切り替え
vim.keymap.set("i", "<C-g><C-u>", "<esc>gUiwgi")  -- 全部大文字
vim.keymap.set("i", "<C-g><C-l>", "<esc>guiwgi")  -- 全部小文字
vim.keymap.set("i", "<C-g><C-k>", "<esc>bgUlgi")  -- 先頭大文字

-- 置換の設定
vim.keymap.set("n", "S", [[:%s/\V\<<C-r><C-w>\>//g<Left><Left>]])
vim.keymap.set("x", "S", [["zy:%s/\V<C-r><C-r>=escape(@z,'/\')<CR>//gce<Left><Left><Left><Left>]])

-- ペーストの設定
vim.keymap.set("n", "p", "]p`]")
vim.keymap.set("n", "P", "]P`]")

-- vimgrep時の候補移動
vim.keymap.set("n", "[q", ":cprevious<CR>", { silent = true })
vim.keymap.set("n", "]q", ":cnext<CR>", { silent = true })
vim.keymap.set("n", "[Q", ":cfirst<CR>", { silent = true })
vim.keymap.set("n", "]Q", ":clast<CR>", { silent = true })

-- コマンドライン設定
vim.keymap.set("c", "<C-a>", "<Home>")
vim.keymap.set("c", "<C-b>", "<Left>")
vim.keymap.set("c", "<C-f>", "<Right>")
vim.keymap.set("c", "<C-h>", "<BackSpace>")
vim.keymap.set("c", "<C-d>", "<Del>")
vim.keymap.set("c", "<C-e>", "<End>")
vim.keymap.set("c", "<C-n>", "<Down>")
vim.keymap.set("c", "<C-p>", "<Up>")

-- control lの設定
vim.keymap.set("n", "<C-l>", ":nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>")

-- Visualモードでインデントした時の範囲解除を避ける
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- cwin操作
vim.keymap.set("n", "<Leader>op", ":copen<CR>", { silent = true })
vim.keymap.set("n", "<Leader>cl", ":cclose<CR>", { silent = true })

-- タブ操作
vim.keymap.set("n", "<Leader>tn", "gt", { silent = true })
vim.keymap.set("n", "<Leader>tN", "gT", { silent = true })

-- ペーストした部分を選択する
vim.keymap.set("n", "gp", "`[v`]")

-- reload init.lua
vim.keymap.set("n", "<F6>", ":source $MYVIMRC<CR>", { silent = true })

-- ----------------------------------------
--  au settings
-- ----------------------------------------
-- diffでwrapする
vim.api.nvim_create_augroup("diffWrap", { clear = true })
vim.api.nvim_create_autocmd("FilterWritePre", {
  group = "diffWrap",
  pattern = "*",
  callback = function()
    if vim.wo.diff then
      vim.wo.wrap = true
    end
  end
})

-- 特定のファイルタイプでfoldingを無効化
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"json", "yaml", "vim", "markdown"},
  callback = function()
    vim.wo.foldmethod = "manual"
    vim.wo.foldcolumn = "0"
    -- Reset foldopen and foldclose to defaults
    vim.cmd("setlocal foldopen=block,hor,mark,percent,quickfix,search,tag,undo")
    vim.cmd("setlocal foldclose=")
  end
})

-- grep後にcwinを表示
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  pattern = {"make", "grep", "grepadd", "vimgrep", "vimgrepadd"},
  command = "cwin"
})

-- ----------------------------------------
--  set commands
-- ----------------------------------------
-- 現在開いているファイルのディレクトリに移動(バッファ限定)
vim.api.nvim_create_user_command("Lcd", function()
  vim.cmd("lcd %:h")
end, {})

-- Rename {新しいファイル名}
vim.api.nvim_create_user_command("Rename", function(opts)
  vim.cmd("file " .. opts.args)
  vim.cmd("call delete(expand('#'))")
end, { nargs = 1, complete = "file" })

-- ----------------------------------------
--  local .vimrc setting
-- ----------------------------------------
local dir = vim.fn.getcwd()
local vimrc_local = vim.fn.findfile(".vimrc.local", vim.fn.fnameescape(dir) .. ";")

if #vimrc_local > 1 then
  local rc = vim.fn.fnamemodify(vimrc_local, ":p:h") .. "/.vimrc.local"
  vim.cmd("source " .. rc)
end

-- ----------------------------------------
--  plugin settings
-- ----------------------------------------
-- textobj-multiblock
vim.keymap.set("o", "ab", "<Plug>(textobj-multiblock-a)")
vim.keymap.set("o", "ib", "<Plug>(textobj-multiblock-i)")
vim.keymap.set("x", "ab", "<Plug>(textobj-multiblock-a)")
vim.keymap.set("x", "ib", "<Plug>(textobj-multiblock-i)")

-- coc
vim.g.coc_global_extensions = {
  'coc-lists',
  'coc-json',
  'coc-sh',
  'coc-phpls',
  'coc-html',
  'coc-css',
  'coc-tsserver',
  'coc-solargraph',
  'coc-docker',
  'coc-word',
  'coc-tabnine',
  'coc-pairs',
  'coc-styled-components',
  'coc-lua',
  'coc-svelte'
}

vim.keymap.set("n", "gd", "<Plug>(coc-definition)", { silent = true })
vim.keymap.set("n", "gn", "<Plug>(coc-type-definition)", { silent = true })
vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", { silent = true })
vim.keymap.set("n", "gr", "<Plug>(coc-references)", { silent = true })
vim.keymap.set("n", "gfo", "<Plug>(coc-format)", { silent = true })
vim.keymap.set("n", "<Leader>rn", "<Plug>(coc-rename)", { silent = true })

vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  callback = function()
    vim.fn.CocActionAsync('highlight')
  end
})

vim.keymap.set("n", "Q", function()
  if vim.bo.filetype == 'vim' then
    vim.cmd("execute 'h '.expand('<cword>')")
  else
    vim.fn.CocAction('doHover')
  end
end, { silent = true })

vim.keymap.set("n", "gf", function()
  vim.fn.CocAction('doHover')
end, { silent = true })

-- coc-pairs
vim.keymap.set("i", "<CR>", function()
  if vim.fn['coc#pum#visible']() == 1 then
    return vim.fn['coc#_select_confirm']()
  else
    return [[<C-g>u<CR><C-r>=coc#on_enter()<CR>]]
  end
end, { silent = true, expr = true })

-- coc-css
vim.api.nvim_create_autocmd("FileType", {
  pattern = "css",
  callback = function()
    vim.opt_local.iskeyword:append("-")
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "scss",
  callback = function()
    vim.opt_local.iskeyword:append("@-@")
  end
})

-- CocList grep
vim.api.nvim_create_user_command("Grep", function()
  vim.cmd("CocList grep")
end, {})

vim.keymap.set("n", "<ESC><ESC>g", ":Grep<CR>")

-- fuzzy-motion
vim.keymap.set("n", "ss", ":FuzzyMotion<CR>")
vim.g.fuzzy_motion_labels = {
  'A', 'O', 'E', 'U', 'I', 'D', 'H', 'T', 'N', 'S', 'P', 'Y', 'F', 'G', 'C', 'R', 'L', 'Q', 'J', 'K', 'X', 'B', 'M', 'W', 'V', 'Z'
}

-- fzf
vim.opt.rtp:append("/opt/homebrew/opt/fzf")
vim.keymap.set("n", ":", ":Buffers<CR>'", { silent = true })
vim.keymap.set("n", "q:", ":History:<CR>'", { silent = true })
vim.keymap.set("n", "<Leader>?", ":GFiles?<CR>'", { silent = true })
vim.keymap.set("n", "<Leader>u", ":GFiles<CR>'", { silent = true })
vim.keymap.set("n", "<Leader>d", ":History<CR>'", { silent = true })
vim.keymap.set("n", "<Leader>r", ":Tags<CR>", { silent = true })

-- columnskip
vim.keymap.set({"n", "o", "x", "v"}, "\\h", "<Plug>(columnskip:nonblank:next)", { silent = true })
vim.keymap.set({"n", "o", "x", "v"}, "\\t", "<Plug>(columnskip:nonblank:prev)", { silent = true })

-- copilot
vim.keymap.set("i", "<C-Space>", 'copilot#Accept("<CR>")', { silent = true, expr = true, script = true })
vim.keymap.set("i", "<C-l>", "<Plug>(copilot-next)", { silent = true })
vim.keymap.set("i", "<C-k>", "<Plug>(copilot-previous)", { silent = true })

-- emmet
vim.g.user_emmet_install_global = 0
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"html", "css", "php", "markdown", "javascript", "javascriptreact", "typescriptreact", "eruby", "astro"},
  command = "EmmetInstall"
})

-- fzf
vim.g.fzf_preview_window = ''
vim.g.fzf_buffers_jump = 1
vim.g.fzf_layout = { down = '40%' }

-- kensaku-search
vim.keymap.set("c", "<CR>", "<Plug>(kensaku-search-replace)<CR>")

-- operator-replace
vim.keymap.set("n", "^", "<Plug>(operator-replace)")

-- JpFormat
vim.keymap.set("n", "gL", ":JpFormatAll<CR>")
vim.g.JpFormatMarker = "  "

-- EasyAlign
vim.keymap.set("v", "<Enter>", "<Plug>(EasyAlign)")
vim.keymap.set("n", "ga", "<Plug>(EasyAlign)")

-- gina
vim.keymap.set("n", "ldo", "<Plug>(gina-diffget-l)")
vim.keymap.set("n", "rdo", "<Plug>(gina-diffget-r)")

-- ----------------------------------------
--  color setting
-- ----------------------------------------
vim.cmd("set t_Co=256")
vim.cmd("syntax on")
vim.g.nvcode_termcolors = 256
vim.cmd("hi clear")
vim.cmd("colorscheme kanagawa")
vim.opt.cursorline = true

-- ----------------------------------------
--  module imports
-- ----------------------------------------
-- Set the path to your lua modules
local lua_path = vim.fn.expand("~/.config/lua")
local function load_module(name)
  local module_path = lua_path .. "/" .. name .. ".lua"
  if vim.fn.filereadable(module_path) == 1 then
    vim.cmd("luafile " .. module_path)
  else
    print("Warning: Could not load module " .. name .. " from " .. module_path)
  end
end

-- モジュールをループで読み込み
local modules = {"gitsigns", "hlchunk", "hop", "oil", "treesitter", "copilotc"}
for _, name in ipairs(modules) do
  load_module(name)
end

-- ----------------------------------------
--  Dvorak setting
-- ----------------------------------------
-- 共通のDvorakマッピングを設定する関数
local function setup_dvorak_mappings(mode)
  -- 基本的なキーマッピング
  local basic_maps = {
    {"H", "J"}, {"J", "E"}, {"K", "B"},
    {"j", "e"}, {"k", "b"}, {"l", "<Nop>"}
  }

  -- カーソル移動用のマッピング（silent, nowait設定付き）
  local cursor_maps = {
    {"d", "h"}, {"gh", "j"}, {"h", "gj"},
    {"gt", "k"}, {"t", "gk"}, {"n", "l"}
  }

  -- 基本マッピング適用
  for _, m in ipairs(basic_maps) do
    vim.keymap.set(mode, m[1], m[2])
  end

  -- カーソル移動マッピング適用
  for _, m in ipairs(cursor_maps) do
    vim.keymap.set(mode, m[1], m[2], { silent = true, nowait = true })
  end
end

-- ノーマルモード固有のマッピング
vim.keymap.set("n", "e", "d")
vim.keymap.set("n", "E", "D")
vim.keymap.set("n", "ee", "dd")
vim.keymap.set("n", "z;", "zr")
vim.keymap.set("n", "z+", "zR")
vim.keymap.set("n", "r", "n")
vim.keymap.set("n", "R", "N")
vim.keymap.set("n", "zh", "zj")
vim.keymap.set("n", "zt", "zk")

-- ビジュアルモード固有のマッピング
vim.keymap.set("v", "e", "d")

-- 両モードに共通のDvorakマッピングを適用
setup_dvorak_mappings("n")
setup_dvorak_mappings("v")

-- vim: set ts=2 sw=2 et :
