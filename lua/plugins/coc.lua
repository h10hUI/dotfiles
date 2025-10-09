-- ----------------------------------------
--  COC settings
-- ----------------------------------------
local function setup()
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

  -- 診断(エラー/警告)のジャンプ
  vim.keymap.set("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
  vim.keymap.set("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })
  -- エラーのみにジャンプ（警告をスキップ）
  vim.keymap.set("n", "[e", "<Plug>(coc-diagnostic-prev-error)", { silent = true })
  vim.keymap.set("n", "]e", "<Plug>(coc-diagnostic-next-error)", { silent = true })

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
end

return { setup = setup }
