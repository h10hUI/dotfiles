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

  -- bw コマンドを current buffer 以外の全バッファで実行
  vim.api.nvim_create_user_command("Bw", function()
    local current_buf = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) then
        local buftype = vim.bo[buf].buftype
        local modified = vim.bo[buf].modified
        if buftype == '' and not modified then
          vim.api.nvim_buf_delete(buf, {})
        end
      end
    end
  end, { desc = "Close other unmodified buffers" })
end

return { setup = setup }
