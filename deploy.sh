#!/bin/bash -e

DOT_DIRECTORY="${HOME}/dotfiles"
CONFIG_DIRECTORY="${HOME}/.config"
NEOVIM_DIRECTORY="${CONFIG_DIRECTORY}/nvim"
KARABINER_DIRECTORY="${CONFIG_DIRECTORY}/karabiner"

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

  # ln command
  ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
done

if [ ! -d ${NEOVIM_DIRECTORY} ] ; then
  mkdir -p ${NEOVIM_DIRECTORY}/backup ${NEOVIM_DIRECTORY}/swap ${NEOVIM_DIRECTORY}/undo
  cp -fv ${DOT_DIRECTORY}/init.vim ${NEOVIM_DIRECTORY} ${DOT_DIRECTORY}/gitsigns.lua ${NEOVIM_DIRECTORY}
fi

if [ ! -d ${KARABINER_DIRECTORY} ]; then
  mkdir -p ${KARABINER_DIRECTORY}
  cp -fv ${DOT_DIRECTORY}/karabiner.json ${KARABINER_DIRECTORY}
fi

cp -fv ${DOT_DIRECTORY}/.Brewfile ${HOME}/.Brewfile
cp -fv ${DOT_DIRECTORY}/starship.toml ${CONFIG_DIRECTORY}
cp -fv ${DOT_DIRECTORY}/lua ${CONFIG_DIRECTORY}

echo "$(tput setaf 2)Deploy dotfiles complete! :)$(tput sgr0)"
