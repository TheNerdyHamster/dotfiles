local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "tokyonight"

config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 12

config.enable_tab_bar = true

config.window_decorations = "RESIZE"

-- config.window_background_opacity = 0.8
-- config.macos_window_background_blur = 10

config.automatically_reload_config = false

config.keys = {
  {
    key = 'r',
    mods = 'CMD|SHIFT',
    action = wezterm.action.ReloadConfiguration,
  },
}

return config
