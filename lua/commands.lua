-- ----------------------------------------
--  Custom commands
-- ----------------------------------------
local function setup()
  -- 現在開いているファイルのディレクトリに移動(バッファ限定)
  vim.api.nvim_create_user_command("Lcd", function()
    vim.cmd("lcd %:h")
  end, {})

  -- Rename {新しいファイル名}
  vim.api.nvim_create_user_command("Rename", function(opts)
    vim.cmd("file " .. opts.args)
    vim.cmd("call delete(expand('#'))")
  end, { nargs = 1, complete = "file" })
end

return { setup = setup }