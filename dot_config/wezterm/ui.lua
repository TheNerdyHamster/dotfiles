local vars = require('vars')
local wezterm = require('wezterm')

local format_title = function(title, is_active, max_width)
    local background = { Background = { Color = "#1f1f28" } }
    local title_len = #title
    local pad_len = math.floor((max_width - title_len) / 2)

    local formatted_title = {
        Text = string.rep(" ", pad_len) .. title .. string.rep(" ", pad_len),
    }

    if is_active then
        return { formatted_title }
    else
        return { formatted_title }
    end
end

local user_var_tab_title_key = "tab_title"
wezterm.on("format-tab-title", function (tab, tabs, panes, config, hover, max_width)
    if type(tab.tab_title) == "string" and #tab.tab_title > 0 then
        return format_title(tab.tab_title, tab.is_active, max_width)
    end
    return format_title("temp", tab.is_active, max_width)
end)

wezterm.on("update-right-status", function (window)
    local date = wezterm.strftime("%Y-%m-%d %H:%M:%S ")
    local mode = vars.is_resize_mode and "Resize mode Activated " or ""
    window:set_right_status(mode .. date)
end)

wezterm.on("user-var-changed", function (window, pane, name, value)
    wezterm.log_info("user-var-changed", name, value)
    if name == user_var_tab_title_key then
        pane:tab():set_title(value)
    end
end)

return {
    color_scheme = "Tokyo Night",
    font = wezterm.font("Hack Nerd Font Mono"),
    font_size = 12,
    adjust_window_size_when_changing_font_size = false,
    tab_max_width = 14,
    window_decorations = "RESIZE",
    window_background_opacity = 0.9,
    macos_window_background_blur = 50,
    enable_tab_bar = true,
    tab_bar_at_bottom = true,
}
