# AI プロジェクト固有設定 (CopilotChat & CodeCompanion)

プロジェクトルートに設定ファイルを置くことで、CopilotChatとCodeCompanion両方でプロジェクト固有の設定を適用できます。

## 推奨: Markdownファイルを使った共通設定

CopilotChatとCodeCompanionで設定を共通化するために、Markdownファイルから読み込む方式を推奨します。

### ファイル構成
```
プロジェクトルート/
  ├── .ai-prompt.md              # 共通AIプロンプト（Markdown）
  └── .copilotchat-config.lua     # CopilotChat設定
```

**注意**: CodeCompanion は memory 機能で `.ai-prompt.md` を読み込みます（グローバル設定に追加済み）

### .ai-prompt.md の例（最低限）
```markdown
このプロジェクトはNext.js + TypeScriptを使用しています。
回答は日本語でお願いします。
```

### .codecompanion.lua の雛形（最低限）
```lua
-- CodeCompanion プロジェクト固有設定
-- 注意: codecompanion.nvim はプロジェクトローカルの .codecompanion.lua を
-- 自動的に読み込む機能はありません。代わりに memory 機能を使用してください。
-- グローバル設定の lua/plugins/codecompanion.lua に以下を追加：
--
-- memory = {
--   opts = { chat = { enabled = true } },
--   default = {
--     description = "Project-specific AI prompt files",
--     parser = "claude",
--     files = { ".ai-prompt.md", "CLAUDE.md" },
--   },
-- }
```

### .copilotchat-config.lua の雛形（最低限）
```lua
-- CopilotChat プロジェクト固有設定
local md_path = vim.fn.getcwd() .. '/.ai-prompt.md'
local system_prompt = nil

if vim.fn.filereadable(md_path) == 1 then
  local file = io.open(md_path, 'r')
  if file then
    system_prompt = file:read('*all')
    file:close()
  end
end

return {
  system_prompt = system_prompt,
}
```

## プラグイン固有設定の追加

### CodeCompanion: memory 機能で .ai-prompt.md を読み込む
```lua
-- グローバル設定 lua/plugins/codecompanion.lua に追加
require("codecompanion").setup({
  memory = {
    opts = {
      chat = {
        enabled = true,
      },
    },
    default = {
      description = "Project-specific AI prompt files",
      parser = "claude",
      files = {
        ".ai-prompt.md",
        "CLAUDE.md",
        "CLAUDE.local.md",
      },
    },
  },
})
```

### CopilotChat: プロンプトを追加
```lua
local md_path = vim.fn.getcwd() .. '/.ai-prompt.md'
local system_prompt = nil

if vim.fn.filereadable(md_path) == 1 then
  local file = io.open(md_path, 'r')
  if file then
    system_prompt = file:read('*all')
    file:close()
  end
end

return {
  system_prompt = system_prompt,
  prompts = {
    ProjectReview = {
      prompt = "プロジェクトの規約に従ってコードレビューしてください",
      mapping = '<leader>cpr',
      description = "プロジェクト規約によるレビュー",
    },
  },
}
```

## 詳細な .ai-prompt.md の例

```markdown
# プロジェクト AI 設定

このプロジェクトはNext.js + TypeScriptを使用しています。

## コーディング規約
- 回答は日本語でお願いします
- コンポーネントはfunction宣言で書いてください
- インデントは2スペース
- テストはJestとTesting Libraryを使用してください

## 技術スタック
- Frontend: Next.js 14, React, TypeScript
- Styling: Tailwind CSS
- State Management: Zustand
```

**この方式の利点:**
- **一元管理**: `.ai-prompt.md` を編集するだけで両方のプラグインに反映
- **Markdown記法**: 読みやすく、編集しやすい
- **バージョン管理**: Markdownなのでdiffが見やすい
- **プラグイン設定変更不要**: グローバル設定はそのまま

## 使用例

### Web開発プロジェクト
```markdown
# Web開発プロジェクト AI 設定

このプロジェクトはNext.js + TypeScriptを使用したWebアプリケーションです。

## 基本方針
- 回答は日本語でお願いします
- コードの説明は簡潔に
- ベストプラクティスに従った実装を推奨

## 技術スタック
- Frontend: Next.js 14, React 18, TypeScript
- Styling: Tailwind CSS
- State: Zustand
- Testing: Jest, Testing Library

## コーディング規約
- コンポーネントはfunction宣言
- Props型は明示的に定義
- インデント: 2スペース
- セミコロン: 必須
```

### Python/Djangoプロジェクト
```markdown
# Django プロジェクト AI 設定

このプロジェクトはPython + Djangoを使用したWebアプリケーションです。

## 基本方針
- 回答は日本語でお願いします
- PEP 8に準拠したコードを書いてください
- 型ヒントを必ず使用してください

## 技術スタック
- Backend: Django 4.2, Python 3.11
- Database: PostgreSQL
- Testing: pytest, pytest-django

## コーディング規約
- インデント: 4スペース
- 型ヒント必須
- Docstring: Google Style
```

## 設定の適用

1. プロジェクトルートに `.ai-prompt.md` を作成
2. CopilotChat用に `.copilotchat-config.lua` を作成
3. CodeCompanion は memory 機能で自動的に `.ai-prompt.md` を読み込む
4. Neovimを再起動
5. 両方のAIプラグインで共通のプロンプトが適用される

## キーバインド

### CodeCompanion
- `<leader>aa` - チャットを開く
- `<leader>ai` - インラインアシスタント
- `<leader>ac` - アクション選択
- `<leader>at` - チャットトグル
- `<leader>aq` - クイック質問

### CopilotChat
- `<leader>ce` - コード説明
- `<leader>cr` - コードレビュー
- `<leader>cf` - コード修正
- `<leader>ct` - テストコード生成
- `<leader>cc` - コミットメッセージ生成

## トラブルシューティング

### プロンプトが反映されない
- `.ai-prompt.md` のファイルパスを確認
- Neovimを再起動
- `:messages` でエラーがないか確認

### 文字エンコーディングエラー
- `.ai-prompt.md` がUTF-8で保存されているか確認

### 両方のプラグインで異なる動作をさせたい場合
- それぞれの `.lua` ファイルで追加の設定を記述
- `opts` や `prompts` を追加で定義可能