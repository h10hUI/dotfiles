#!/bin/bash -e

########################################
# Deploy                               #
########################################
DOT_DIRECTORY="${HOME}/dotfiles"
NEOVIM_DIRECTORY="${HOME}/.config/nvim"

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

  ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
done

if [ ! -d ${NEOVIM_DIRECTORY} ] ; then
  mkdir -p ${NEOVIM_DIRECTORY}/backup ${NEOVIM_DIRECTORY}/swap ${NEOVIM_DIRECTORY}/undo
  cp -fv ${HOME}/dotfiles/init.vim ${HOME}/.config/nvim
fi

cp -fv ${HOME}/dotfiles/.Brewfile ${HOME}/.Brewfile
cp -fv ${HOME}/dotfiles/starship.toml ${HOME}/.config/

echo "$(tput setaf 2)Deploy dotfiles complete! :)$(tput sgr0)"
