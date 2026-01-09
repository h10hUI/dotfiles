#!/bin/bash
# Config file auto-sync with read-only protection

# Make ~/.config/nvim/lua read-only initially
chmod -R a-w ~/.config/nvim/lua

nohup fswatch -o ~/.config/nvim/init.lua ~/dotfiles/lua ~/.config/wezterm | \
while read; do
  rsync -r ~/.config/nvim/init.lua ~/dotfiles/init.lua
  chmod -R u+w ~/.config/nvim/lua
  rsync -r ~/dotfiles/lua ~/.config/nvim
  chmod -R a-w ~/.config/nvim/lua
  rsync -r ~/.config/wezterm ~/dotfiles
done &

echo "Config sync started (PID: $!)"
echo "~/.config/nvim/lua is read-only (syncs from ~/dotfiles/lua only)"
