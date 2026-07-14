-- ----------------------------------------
--  Autocmd settings
-- ----------------------------------------
local function setup()
  -- diffモードに入ったらnowrap(scrollbindとのズレを防ぐ)
  vim.api.nvim_create_autocmd("OptionSet", {
    pattern = "diff",
    callback = function()
      if vim.v.option_new then
        vim.wo.wrap = false
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
