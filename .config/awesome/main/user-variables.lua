local home = os.getenv("HOME")

local _M = {

  -- Default terminal
  terminal = "alacritty",

  -- Defualt editor
  editor = "emacs",

  -- Default modkey
  modkey = "Mod4",

  -- Custom wallpaper
  -- wallpaper = nil,
  wallpaper = home .. "/Pictures/blossom-tree-cliff.jpeg",

  -- Statusbar icons path
  icon_path = home .. "/.config/awesome/themes/icons/"
}

return _M
