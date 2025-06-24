PATH=/usr/local/bin:$PATH

### FDKのPATHを通す
# {{{
  export PATH=PATH=~/bin/FDK/Tools/osx:$PATH
# }}}

# git diff-highlighterのパスを通す
# {{{
  export PATH=$PATH:/opt/homebrew/share/git-core/contrib/diff-highlight
# }}}

# ripgreprcのパスを通す
# {{{
  export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
# }}}

# awscliのパスを通す
# {{{
  export PATH="/usr/local/opt/awscli@1/bin:$PATH"
# }}}

# ni のパスを通す
export NI_CONFIG_FILE="$HOME/.nirc"

# git のエディタは nvim にする
export GIT_EDITOR=nvim

# cargoのパスを通す
. "$HOME/.cargo/env"

# denoのパスを通す
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# envchain から環境変数を読み込む
# export ANTHROPIC_API_KEY=`envchain anthropic printenv ANTHROPIC_API_KEY`
