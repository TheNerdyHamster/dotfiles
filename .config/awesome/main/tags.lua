-- Standard awesome lib
local awful = require("awful")

local _M = {}

local icon_path = RC.vars.icon_path

function _M.get()
  local tags = {}

  local tagpairs = {
    names = {
      "Editor",
      "Web",
      "Term",
      "Social",
      "Mail",
      "Movie",
      "❼ 七",
      " ❽ 八",
      "❾ 九" },

    icons = {
      icon_path .. "keyboard-solid.svg",
      icon_path .. "globe-solid.svg",
      icon_path .. "terminal-solid.svg",
      icon_path .. "chat.png",
      nil,
      nil,
      nil,
      nil,
      nil
    }

  }


  awful.screen.connect_for_each_screen(function(s)
      for key, value in pairs(tagpairs.names) do
        awful.tag.add(value, {
          icon      = tagpairs.icons[key],
          layout    = RC.layouts[1],
          screen    = s,
          selected  = key == 1 
        })
      end
  end)

  return root.tags()
end


return setmetatable(
  {},
  {__call = function(_, ...) return _M.get(...) end }
)
