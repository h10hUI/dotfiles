-- ----------------------------------------
--  Dvorak setting
-- ----------------------------------------
local function setup()
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
  -- Dvorak fold navigation remapping
  vim.keymap.set("n", "zh", "zj", { remap = false })
  vim.keymap.set("n", "zt", "zk", { remap = false })

  -- ビジュアルモード固有のマッピング
  vim.keymap.set("v", "e", "d")

  -- 両モードに共通のDvorakマッピングを適用
  setup_dvorak_mappings("n")
  setup_dvorak_mappings("v")
end

return { setup = setup }
