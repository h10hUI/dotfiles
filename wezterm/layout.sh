#!/bin/bash -ex

wezterm cli split-pane --top --percent 70 \
  && wezterm cli split-pane --right --percent 33 \
  && wezterm cli split-pane --right --percent 50 \
  && wezterm cli activate-pane-direction left

echo "Set tab title"
read TITLE
wezterm cli set-tab-title "$TITLE" \
  && wezterm cli activate-pane-direction up
