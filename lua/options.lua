-- ----------------------------------------
--  Basic Settings
-- ----------------------------------------
local function setup()
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
end

return { setup = setup }