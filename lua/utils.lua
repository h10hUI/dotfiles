-- ----------------------------------------
--  Helper Functions
-- ----------------------------------------
local M = {}

-- 保存時に行末の空白を除去する
M.remove_dust = function()
  local cursor = vim.fn.getpos(".")
  vim.cmd([[%s/\s\+$//ge]])
  vim.fn.setpos(".", cursor)
end

-- 全角スペースの設定
M.zenkaku_space = function()
  vim.cmd([[highlight ZenkakuSpace cterm=reverse ctermfg=darkgray gui=reverse guifg=darkgray]])
end

-- visual モードの時にスターで選択位置のコードを検索するようにする
function _G.v_set_search()
  local temp = vim.fn.getreg("s")
  vim.cmd('normal! gv"sy')
  vim.fn.setreg("/", "\\V" .. vim.fn.substitute(vim.fn.escape(vim.fn.getreg("s"), "/\\"), "\\n", "\\\\n", "g"))
  vim.fn.setreg("s", temp)
end

-- Floating windowにフォーカスを当てる
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

-- 空行編集時の挙動
M.handle_empty_line = function(action)
  return function()
    if vim.fn.empty(vim.fn.getline('.')) == 1 then
      return '"_cc'
    else
      return action
    end
  end
end

-- Setup autocmds
M.setup_autocmds = function()
  -- 保存時に行末の空白を除去する
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
      if vim.bo.filetype ~= "markdown" then
        M.remove_dust()
      end
    end
  })

  -- 全角スペースの設定
  if vim.fn.has('syntax') == 1 then
    vim.api.nvim_create_augroup("ZenkakuSpace", { clear = true })
    vim.api.nvim_create_autocmd({"ColorScheme"}, {
      group = "ZenkakuSpace",
      callback = M.zenkaku_space
    })
    vim.api.nvim_create_autocmd({"VimEnter", "WinEnter"}, {
      group = "ZenkakuSpace",
      command = "match ZenkakuSpace /　/"
    })
    M.zenkaku_space()
  end
end

return M