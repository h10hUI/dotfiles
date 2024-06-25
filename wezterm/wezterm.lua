-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- Read the keybindings from the file,
local keybind = require 'keybind'

-- Setup screen size
local mux = wezterm.mux

-- This table will hold the configuration.
local config = {
  -- colors
  color_scheme = 'kanagawabones',
  window_background_opacity = 0.95,
  -- font
  font = wezterm.font_with_fallback({
    { family = 'LigaSFMono Nerd Font', weight = 'Bold' },
    { family = 'Source Han Code JP', weight = 'Bold' },
  }),
  font_size = 15.0,
  -- for macOS
  macos_forward_to_ime_modifier_mask = 'SHIFT|CTRL',
  -- block the default keybindings
  disable_default_key_bindings = true,
  -- set the leader key
  leader = { key = 's', mods = 'CTRL', timeout_milliseconds = 2000 },
  -- set tab bar
  tab_bar_at_bottom = true,
}

-- Keybindings
config.keys = keybind.keys
config.key_tables = keybind.key_tables

-- Initialize screen size
wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end)

-- and finally, return the configuration to wezterm
return config
