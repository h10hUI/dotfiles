#!/bin/bash -e

DOT_DIRECTORY="${HOME}/dotfiles"
NEOVIM_DIRECTORY="${HOME}/.config/nvim"
KARABINER_DIRECTORY="${HOME}/.config/karabiner"

echo "Start Deploy ..."
cd ${DOT_DIRECTORY}
for f in .??*
do
  # ignore file & directory
  [[ ${f} = ".git" ]] && continue
  [[ ${f} = "init.vim" ]] && continue
  [[ ${f} = ".Brewfile" ]] && continue
  [[ ${f} = "starship.toml" ]] && continue
  [[ ${f} = "changelog.config.js" ]] && continue
  [[ ${f} = "setup.sh" ]] && continue
  [[ ${f} = "Makefile" ]] && continue
  [[ ${f} = "karabiner.json" ]] && continue
  ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
done

if [ ! -d ${NEOVIM_DIRECTORY} ] ; then
  mkdir -p ${NEOVIM_DIRECTORY}/backup ${NEOVIM_DIRECTORY}/swap ${NEOVIM_DIRECTORY}/undo
  cp -fv ${HOME}/dotfiles/init.vim ${HOME}/.config/nvim
fi

if [ ! -d ${KARABINER_DIRECTORY} ]; then
  mkdir -p ${KARABINER_DIRECTORY}
  cp -fv ${DOT_DIRECTORY}/karabiner.json ${KARABINER_DIRECTORY}
fi

cp -fv ${DOT_DIRECTORY}/.Brewfile ${HOME}/.Brewfile
cp -fv ${DOT_DIRECTORY}/starship.toml ${HOME}/.config/

echo "$(tput setaf 2)Deploy dotfiles complete! :)$(tput sgr0)"
