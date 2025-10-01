# CodeCompanion プロジェクト固有設定

プロジェクトルートに `.codecompanion.lua` ファイルを置くことで、そのプロジェクト固有のCodeCompanion設定を適用できます。

## 設定ファイルの例

```lua
-- .codecompanion.lua
return {
  opts = {
    system_prompt = function(opts)
      return [[
このプロジェクトは○○を使用しています。
回答は日本語でお願いします。
コードスタイルは○○に従ってください。
      ]]
    end,
  },
}
```

## 設定項目

### prompts
プロジェクト固有のカスタムプロンプトを定義できます。

- `strategy`: "chat", "inline", "agent" のいずれか
- `description`: プロンプトの説明
- `prompts`: プロンプト配列
  - `role`: "system", "user", "assistant"
  - `content`: プロンプトの内容

## 使用例

### Web開発プロジェクト
```lua
-- .codecompanion.lua
return {
  opts = {
    system_prompt = function(opts)
      return [[
このプロジェクトはNext.js + TypeScriptを使用しています。
- 回答は日本語でお願いします
- コンポーネントはfunction宣言で書いてください
- テストはJestとTesting Libraryを使用してください
- SEOを考慮した実装をしてください
      ]]
    end,
  },
  prompts = {
    ["ComponentReview"] = {
      strategy = "inline",
      description = "Reactコンポーネントのレビュー",
      prompts = {
        {
          role = "user",
          content = "このReactコンポーネントをレビューして、改善点を提案してください。",
        },
      },
    },
  },
}
```

### Python プロジェクト
```lua
-- .codecompanion.lua
return {
  opts = {
    system_prompt = function(opts)
      return [[
このプロジェクトはPython + Djangoを使用しています。
- 回答は日本語でお願いします
- PEP 8に従ったコードを書いてください
- テストはpytestを使用してください
- 型ヒントを必ず記述してください
      ]]
    end,
  },
}
```

## システムプロンプトの設定

全てのプロンプトに共通のシステムプロンプトを設定する場合：

```lua
-- .codecompanion.lua
return {
  opts = {
    system_prompt = function(opts)
      return [[
このプロジェクトの共通ルール：
- 回答は日本語
- インデントは2スペース
- セミコロンは必須
      ]]
    end,
  },
  prompts = {
    -- カスタムプロンプト
  },
}
```

**重要**: `system_prompt`は必ず`opts`の中に関数として定義してください。

## 設定の適用

1. プロジェクトルートに `.codecompanion.lua` を作成
2. Neovimを再起動（または `:e` で再読み込み）
3. CodeCompanionで新しいプロンプトが利用可能になる

## 注意点

- 設定ファイルはLua形式のみ（Markdown形式は非対応）
- プロジェクトルートに配置する必要がある
- 構文エラーがあると読み込まれないので注意

## キーバインド

- `<leader>aa` - チャットを開く
- `<leader>ai` - インラインアシスタント
- `<leader>ac` - アクション選択（プロジェクト固有プロンプトを含む）
- `<leader>at` - チャットトグル
- `<leader>aq` - クイック質問