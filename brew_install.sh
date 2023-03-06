#!/bin/bash -e

# has check
has() {
  type "$1" > /dev/null 2>&1
}

if has "brew" ; then
  echo "$(tput setaf 2)Already installed Homebrew :)$(tput sgr0)"
else
  echo "Installing Homebrew ..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
