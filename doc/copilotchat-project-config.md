# CopilotChat プロジェクト固有設定

プロジェクトルートに `.copilotchat-config.lua` または `.copilotchat.lua` ファイルを置くことで、そのプロジェクト固有のCopilotChat設定を適用できます。

## 設定ファイルの例

```lua
-- .copilotchat-config.lua
return {
  system_prompt = [[
このプロジェクトは○○を使用しています。
回答は日本語でお願いします。
コードスタイルは○○に従ってください。
  ]],
  prompts = {
    ProjectExplain = {
      prompt = "このプロジェクト固有の説明をしてください",
      mapping = '<leader>cpe',
      description = "プロジェクト固有の説明"
    },
    CustomReview = {
      prompt = "プロジェクトの規約に従ってレビューしてください",
      mapping = '<leader>cpr',
      description = "プロジェクト規約によるレビュー"
    }
  }
}
```

## 設定項目

### system_prompt
- プロジェクト全体で適用されるシステムプロンプト
- プロジェクトの技術スタック、コーディング規約、言語設定など

### prompts
- プロジェクト固有のカスタムプロンプト
- 既存のプロンプトに追加される形で設定される
- `mapping`: キーマッピング
- `description`: プロンプトの説明
- `prompt`: 実際のプロンプト内容

## 使用例

### Web開発プロジェクト
```lua
return {
  system_prompt = [[
このプロジェクトはNext.js + TypeScriptを使用しています。
- 回答は日本語でお願いします
- コンポーネントはfunction宣言で書いてください
- テストはJestとTesting Libraryを使用してください
- SEOを考慮した実装をしてください
  ]],
  prompts = {
    ComponentExplain = {
      prompt = "このReactコンポーネントの動作と使い方を説明してください",
      mapping = '<leader>cce',
      description = "Reactコンポーネントの説明"
    }
  }
}
```

### Python プロジェクト
```lua
return {
  system_prompt = [[
このプロジェクトはPython + Djangoを使用しています。
- 回答は日本語でお願いします
- PEP 8に従ったコードを書いてください
- テストはpytestを使用してください
- 型ヒントを必ず記述してください
  ]],
  prompts = {
    ModelExplain = {
      prompt = "このDjangoモデルの設計と関係性を説明してください",
      mapping = '<leader>cme',
      description = "Djangoモデルの説明"
    }
  }
}
```

## 設定の適用

1. プロジェクトルートに設定ファイルを作成
2. Neovimを再起動（または `:luafile lua/plugins/copilotc.lua` で再読み込み）
3. CopilotChatで新しいプロンプトやシステムプロンプトが適用される

設定が正しく読み込まれない場合は、ファイルパスや構文エラーを確認してください。