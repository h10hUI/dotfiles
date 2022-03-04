PATH=/usr/local/bin:$PATH

### FDKのPATHを通す
# {{{
  export PATH=PATH=~/bin/FDK/Tools/osx:$PATH
# }}}

# anyenvのパスを通す
# {{{
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init - zsh)"
  # rbenvのPATHを通す
    export PATH="$HOME/.rbenv/bin:$PATH"
    if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi
  # rbenvの設定用
    if [ -d ${HOME}/.rbenv  ] ; then
      export PATH="${HOME}/.rbenv/bin:${HOME}/.rbenv/shims:${PATH}"
      eval "$(rbenv init - zsh)"
    fi
  # pyenvのPATHを通す
    # export PYENV_ROOT="${HOME}/.pyenv"
    # export PATH=${PYENV_ROOT}/bin:$PATH
    # eval "$(pyenv init - zsh)"
  # ndenvのPATHを通す
    if [ -d ${HOME}/.anyenv ] ; then
    export PATH="$HOME/.anyenv/bin:$PATH"
      eval "$(anyenv init - zsh)"
         for D in `ls $HOME/.anyenv/envs`
         do
             export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
         done
    fi
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

# cargoのパスを通す
# {{{
  # source "$HOME/.cargo/env"
# }}}

# phpのパスを通す
# {{{
  # export PATH="/usr/local/opt/php@7.4/bin:$PATH"
  # export PATH="/usr/local/opt/php@7.4/sbin:$PATH"
# }}}
