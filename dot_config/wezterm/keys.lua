local vars = require('vars')
local wezterm = require('wezterm')
local act = wezterm.action

local function activate_pane(window, pane, pane_direction, vim_direction)
    local isViProcess = pane:get_foreground_process_name():find("n?vim") ~= nil
    if isViProcess then
        window:perform_action(act.SendKey({ key = vim_direction, mods = "CTRL" }), pane)
    else
        window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
    end
end

wezterm.on("activate_pane_r", function (window, pane)
    activate_pane(window, pane, "Right", "l")
end)
wezterm.on("activate_pane_l", function (window, pane)
    activate_pane(window, pane, "Left", "h")
end)
wezterm.on("activate_pane_u", function (window, pane)
    activate_pane(window, pane, "Up", "k")
end)
wezterm.on("activate_pane_d", function (window, pane)
    activate_pane(window, pane, "Down", "j")
end)

return {
    disable_default_key_bindings = true,
    leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 },
    keys = {
        { key = "q", mods = "LEADER", action = act.QuitApplication },
        { key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
        { key = "r", mods = "LEADER|SHIFT", action = act.ReloadConfiguration },
        { key = "m", mods = "LEADER", action = act.TogglePaneZoomState },
        { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true}) },
        { key = "t", mods = "LEADER", action = act.PromptInputLine({
            description = "Enter new tab name:",
            action = wezterm.action_callback(function (window, _, line)
                if line then
                    local tab = window:mux_window():spawn_tab({
                        cwd = wezterm.home_dir,
                    })
                    tab:set_title(line)
                    tab:activate()
                end
            end)
        }) },
        { key = "r", mods = "LEADER", action = act.PromptInputLine({
            description = "Enter tab name:",
            action = wezterm.action_callback(function (window, _, line)
                if line then
                    window:active_tab():set_title(line)
                end
            end)
        }) },
        { key = ":", mods = "LEADER", action = act.ActivateCommandPalette },
        { key = "+", mods = "LEADER", action = act.IncreaseFontSize },
        { key = "-", mods = "LEADER", action = act.DecreaseFontSize },
        { key = "=", mods = "LEADER", action = act.ResetFontAndWindowSize },
        { key = "v", mods = "LEADER", action = act.SplitHorizontal{ domain = "CurrentPaneDomain"} },
        { key = "s", mods = "LEADER", action = act.SplitVertical{ domain = "CurrentPaneDomain"} },

        { key = "[", mods = "LEADER", action = act.ActivatePaneDirection("Prev") },
        { key = "]", mods = "LEADER", action = act.ActivatePaneDirection("Next") },

        { key = "{", mods = "LEADER", action = act.MoveTabRelative(-1) },
        { key = "}", mods = "LEADER", action = act.MoveTabRelative(1) },

        { key = "h", mods = "LEADER", action = act.ActivateTabRelative(-1) },
        { key = "l", mods = "LEADER", action = act.ActivateTabRelative(1) },

        { key = "w", mods = "LEADER", action = wezterm.action_callback(function (_, pane)
            local isViProcess = pane:get_foreground_process_name():find("n?vim") ~= nil
            wezterm.log_info("leader+w pressed, isViProcess=[" .. tostring(isViProcess) .. "]")
            if not isViProcess then
                vars.is_resize_mode = true
            end
        end)},
        { key = "Escape", action = wezterm.action_callback(function (window, pane)
            wezterm.log_info("Escape pressed, isViProcess=[" .. tostring(vars.is_resize_mode) .. "]")
            if vars.is_resize_mode then
                vars.is_resize_mode = false
            else
                return window:perform_action(act.SendKey({ key = "Escape" }), pane)
            end
        end)},
        { key = "h", action = wezterm.action_callback(function(window, pane)
            wezterm.log_info("l pressed, is_resize_mode=[" .. tostring(vars.is_resize_mode) .. "]")
            return window:perform_action(
                vars.is_resize_mode and act.AdjustPaneSize({ "Left", 5 }) or act.SendKey({ key = "h" }), pane)
        end)},
        { key = "l", action = wezterm.action_callback(function(window, pane)
            wezterm.log_info("r pressed, is_resize_mode=[" .. tostring(vars.is_resize_mode) .. "]")
            return window:perform_action(
                vars.is_resize_mode and act.AdjustPaneSize({ "Right", 5 }) or act.SendKey({ key = "l" }), pane)
        end)},
        { key = "k", action = wezterm.action_callback(function(window, pane)
            wezterm.log_info("u pressed, is_resize_mode=[" .. tostring(vars.is_resize_mode) .. "]")
            return window:perform_action(
                vars.is_resize_mode and act.AdjustPaneSize({ "Up", 5 }) or act.SendKey({ key = "k" }), pane)
        end)},
        { key = "j", action = wezterm.action_callback(function(window, pane)
            wezterm.log_info("d pressed, is_resize_mode=[" .. tostring(vars.is_resize_mode) .. "]")
            return window:perform_action(
                vars.is_resize_mode and act.AdjustPaneSize({ "Down", 5 }) or act.SendKey({ key = "j" }), pane)
        end)},
        { key = "h", mods = "CTRL", action = act.EmitEvent("activate_pane_l") },
        { key = "j", mods = "CTRL", action = act.EmitEvent("activate_pane_d") },
        { key = "k", mods = "CTRL", action = act.EmitEvent("activate_pane_u") },
        { key = "l", mods = "CTRL", action = act.EmitEvent("activate_pane_r") },
    }
}
