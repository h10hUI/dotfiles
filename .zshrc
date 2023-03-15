### global setting ###
# {{{
# 環境変数
export LANG=ja_JP.UTF-8

# 重複PATHを登録しない
typeset -U path PATH

# 色を使用出来るようにする
autoload -Uz colors
colors

# zmv有効化
autoload -Uz zmv
alias zmv='noglob zmv -W'

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
# }}}

### prompt ###
# {{{
  eval "$(starship init zsh)"
# }}}

### 補完 ###
# {{{
# 補完機能を有効にする
autoload -Uz compinit
compinit -u
# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..
# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
  /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
# 補完関数の表示を強化する
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT
# ファイル補完候補に色を付ける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# 補完に関するオプション
# http://voidy21.hatenablog.jp/entry/20090902/1251918174
setopt auto_param_slash      # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt mark_dirs             # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt list_types            # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
setopt auto_menu             # 補完キー連打で順に補完候補を自動で補完
setopt auto_param_keys       # カッコの対応などを自動的に補完
setopt interactive_comments  # コマンドラインでも # 以降をコメントと見なす
setopt magic_equal_subst     # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt complete_in_word      # 語の途中でもカーソル位置で補完
setopt always_last_prompt    # カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt print_eight_bit  #日本語ファイル名等8ビットを通す
setopt extended_glob  # 拡張グロブで補完(~とか^とか。例えばless *.txt~memo.txt ならmemo.txt 以外の *.txt にマッチ)
setopt globdots # 明確なドットの指定なしで.から始まるファイルをマッチ
bindkey "^I" menu-complete   # 展開する前に補完候補を出させる(Ctrl-iで補完するようにする)
# }}}

### 履歴の検索 ###
# {{{
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
# }}}

### オプション###
# {{{
# 日本語ファイル名を表示可能にする
setopt print_eight_bit
# beep を無効にする
setopt no_beep
# フローコントロールを無効にする
setopt no_flow_control
# '#' 以降をコメントとして扱う
setopt interactive_comments
# ディレクトリ名だけでcdする
setopt auto_cd
cdpath=(.. ~ ~/src)
# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups
# 同時に起動したzshの間でヒストリを共有する
setopt share_history
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
# 高機能なワイルドカード展開を使用する
setopt extended_glob
# }}}

### キーバインド ###
# {{{
# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward
########################################
# Ctrl-^ で cd ..
function cdup() {
  echo
  cd ..
  zle reset-prompt
  return 0
}
zle -N cdup
bindkey '^\^' cdup
# }}}

### エイリアス ###
# {{{
# git関連コマンド
alias g='git'
alias gad='git add'
alias gbr='git branch'
alias gbru='git branch -u `git branch -r | fzf`'
alias gch='git checkout'
alias gcl='git clone'
alias gco='git commit -a'
alias gdi='git diff'
alias gf='git flow'
alias gfe='git fetch -p'
alias gff='git flow feature'
alias gfh='git flow hotfix'
alias gfr='git flow release'
alias gin='git init'
alias glo='git log'
alias gme='git merge'
alias gmy='git mylog'
alias gre='git rebase'
alias gst='git status --short --branch'
# ghqのエイリアス
alias repo='cd $(ghq list -p | fzf)'
# その他エイリアス
alias cp='cp -ip'
alias desktop='cd ~/desktop'
alias f='open .'
alias home='cd ~'
alias kaf='killall Finder'
alias la='ls -aG'
alias ll='ls -lG'
alias ls='ls -laG'
alias mkdir='mkdir -p'
alias mv='mv -i'
alias nv='nvim'
alias pw='pwgen -y'
alias q='exit'
alias rm='rm -i'
alias rmdir='rm -rf'
alias sl='ls -laG'
alias u='cd ../'
alias up='cd ..; ls -lG'
alias uu='cd ../../'
alias uuu='cd ../../../'
alias vi='vim'
alias dox='docker exec -it `docker ps --format "{{.Names}}" | fzf` /bin/bash'
alias dorm='docker rm -f `docker ps -aq`'
# ctagsの設定
alias ctags='`brew --prefix`/bin/ctags'
# purgeの設定
alias purge='sudo purge'
# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '
# docker-compose
alias fig='docker compose'
# tmux関連
alias T='tmux new -s'
alias TK='tmux kill-session -t'
alias TA='tmux a -t'
alias tx='tmux'
alias tls='tmux ls'
alias kat='killall tmux'
# screen関連
alias s='screen'
alias ss='screen -S'
alias sr='screen -r'
alias sls='screen -ls'
alias kas='find /tmp/uscreens/S-hi0711 -exec rm -rf {} +'
#}}}

### グローバルエイリアス ###
# {{{
alias -g L='| less -R'
alias -g G='| grep'
alias -g C='| pbcopy'
alias -g X='| xargs'
alias -g F='| fzf'
alias -g S='| sentaku'
# }}}

### cntrl-z の設定 ###
# {{{
fancy-ctrl-z () {
if [[ $#BUFFER -eq 0 ]]; then
  BUFFER="fg"
  zle accept-line
else
  zle push-input
  zle clear-screen
fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
# }}}

### fzf設定###
# {{{
# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
    -o -type d -print 2> /dev/null | fzf +m) &&
    cd "$dir"
  }
export FZF_DEFAULT_COMMAND='fd --ignore .git -g ""'
# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}
# fshow - git commit browser
fshow() {
  git log --graph --color=always \
  --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
  --bind "ctrl-m:execute:
  (grep -o '[a-f0-9]\{7\}' | head -1 |
  xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
  {}
  FZF-EOF"
}
# fgc - gitのcheckoutにfzfを使う
alias fgc='git branch | fzf | xargs git checkout'
# fgcr - gitのremetoブランチへのcheckoutにfzfを使う
alias fgcr='git checkout `git branch -r | egrep -v "HEAD" | sed "s;origin/;;" | fzf`'
# fremo - gitのremoteブランチをupstreamに設定する
alias fremo='git branch -r | fzf | xargs git branch -u'
# fgd - gitのdiffにfzfを使う
alias fgd='git branch -a | fzf | xargs git diff'
# flog - gitのmylogにfzfを使う
alias flog='git branch -a | fzf | xargs git mylog'
# freb - gitのrebaseにfzfを使う
alias freb='git branch | awk "{print $1}" | egrep -v "\*|master" | fzf | xargs git rebase -ir'
# tm - create new tmux session, or switch to existing one. Works from within tmux too. (@bag-man)
# `tm` will allow you to select your tmux session via fzf.
# `tm irc` will attach to the irc session (if it exists), else it will create it.
tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}
# select-history - historyをfzfで絞り込んで標準出力として返す
function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history
# fnv - neovimの引数をfzfする
fnv() {
  files=$(git ls-files) &&
  selected_files=$(echo "$files" | fzf -m --preview 'head -100 {}') &&
  nvim $selected_files
}
# }}}

### その他設定 ###
# {{{
# fpathの設定
fpath=($(brew --prefix)/share/zsh/functions $fpath)
#for zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)
# git-completionの設定
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
# ghの設定
eval "$(gh completion -s zsh)"
# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified
# 範囲指定できるようにする
# 例 : mkdir {1-3} で フォルダ1, 2, 3を作れる
setopt brace_ccl
# manの補完をセクション番号別に表示させる
zstyle ':completion:*:manuals' separate-sections true
# 変数の添字を補完する
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
# apt-getとかdpkgコマンドをキャッシュを使って速くする
zstyle ':completion:*' use-cache true
# オブジェクトファイルとか中間ファイルとかはfileとして補完させない
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'
# finderで開いているディレクトリに移動
cdf () {
  target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
  if [ "$target" != "" ]
  then
    cd "$target"
    pwd
  else
    echo 'No Finder window found' >&2
  fi
}
# HomeBrew file関連
if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap
fi
# neovimの設定
export XDG_CACHE_HOME=$HOME/.config
export PATH="/usr/local/sbin:$PATH"
# grepの設定
PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/grep/libexec/gnuman:$MANPATH"
# セパレータを設定する
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true
# LS_COLORSを設定しておく
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# zcompileを実行する
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi
# anyenvのパスを通す
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init - zsh)"
# rbenvの設定用
  if [ -d ${HOME}/.rbenv  ] ; then
    export PATH="${HOME}/.rbenv/bin:${HOME}/.rbenv/shims:${PATH}"
    eval "$(rbenv init - zsh)"
  fi
# }}}

### zコマンド###
# {{{
. ~/z/z.sh
# }}}
