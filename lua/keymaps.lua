-- ----------------------------------------
--  Key mappings
-- ----------------------------------------
local utils = require('utils')

local function setup()
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

  -- zz モーション
  vim.fn.writefile({
    '" zz モーション',
    'nmap zz zz<SID>(z1)',
    'nnoremap <script> <SID>(z1)z zt<SID>(z2)',
    'nnoremap <script> <SID>(z2)z zb<SID>(z3)',
    'nnoremap <script> <SID>(z3)z zz<SID>(z1)'
  }, vim.fn.expand('~/tmp/z_cycle.vim'))
  vim.cmd('source ' .. vim.fn.expand('~/tmp/z_cycle.vim'))

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
  vim.keymap.set("n", "j", "gj", { remap = false })
  vim.keymap.set("n", "k", "gk", { remap = false })
  vim.keymap.set("n", "gj", "j", { remap = false })
  vim.keymap.set("n", "gk", "k", { remap = false })

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
  vim.keymap.set("n", ";", ":", { remap = false })
  vim.keymap.set("n", ":", ";", { remap = false })

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
  vim.keymap.set("n", "i", utils.handle_empty_line('i'), { expr = true })
  vim.keymap.set("n", "A", utils.handle_empty_line('A'), { expr = true })

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

  -- visual モードの時にスターで選択位置のコードを検索するようにする
  vim.keymap.set("x", "*", ":call v:lua.v_set_search()<CR>/<C-R>=@/<CR><CR>", { silent = true })
  vim.keymap.set("x", "#", ":call v:lua.v_set_search()<CR>?<C-R>=@/<CR><CR>", { silent = true })

  -- Floating windowにフォーカスを当てる
  if vim.fn.has('nvim') == 1 then
    vim.keymap.set("n", "<C-w><C-w>", ":lua focus_floating()<CR>", { silent = true })
  end
  
  -- CSS値操作用のマッピング
  vim.keymap.set('n', 'cV', 'f:lvt;', { desc = 'CSS値を選択' })
  vim.keymap.set('n', 'dV', 'f:ldt;', { desc = 'CSS値を削除' })
  vim.keymap.set('n', 'cC', 'f:lct;', { desc = 'CSS値を変更' })
end

return { setup = setup }
