local wezterm = require('wezterm')
local act = wezterm.action
local mux = wezterm.mux

wezterm.on("gui-startup", function (cmd)
    local args = {}
    if cmd then
        args = cmd.args
    end

    local home = wezterm.home_dir

    wezterm.log_info(home .. "/Documents/code")

    local general_tab, general_pane, window = mux.spawn_window({
        workspace = "default",
        cwd = home
    })

    general_tab:set_title("General")

    local config_tab = window:spawn_tab({
        --args = args,
        cwd = home .. "/.local/share/chezmoi"
    })
    config_tab:set_title("Chezmoi")

    local code_tab = window:spawn_tab({
        cwd = home .. "/Documents/code/"
    })
    code_tab:set_title("Code")

    local stats_tab, stats_pane = window:spawn_tab({
        cwd = home
    })
    stats_pane:send_text("btop\n")
    stats_tab:set_title("Stats")

    window:gui_window():perform_action(act.ActivateTab(0), general_pane)
end)

return {}
