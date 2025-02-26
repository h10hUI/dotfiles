-- ----------------------------------------
--  Autocmd settings
-- ----------------------------------------
local function setup()
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
end

return { setup = setup }