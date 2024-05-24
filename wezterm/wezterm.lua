local wezterm = require("wezterm")
local config = wezterm.config_builder()
local mux = wezterm.mux

-- config.use_fancy_tab_bar = false
config.native_macos_fullscreen_mode = true

-- Color
local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		-- config.color_scheme = "AdventureTime"
		return "Catppuccin Frappe"
	else
		return "Catppuccin Latte"
	end
end

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

-- Font
config.font = wezterm.font("JetBrains Mono")
config.font_size = 18.0

-- Window
-- config.window_decorations = "RESIZE"
-- https://github.com/letieu/dotfiles/blob/master/dot_config/wezterm/wezterm.lua
config.window_background_opacity = 0.9
config.macos_window_background_blur = 40

config.window_frame = {
	-- The font used in the tab bar.
	font = wezterm.font({ family = "JetBrains Mono", weight = "Bold" }),
	font_size = 16.0,

	-- The overall background color of the tab bar when
	-- the window is focused
	active_titlebar_bg = "#333333",
}

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

wezterm.on("gui-startup", function()
	---@diagnostic disable-next-line: unused-local
	local tab, _, window = mux.spawn_window({})
	window:gui_window():toggle_fullscreen()
end)

-- config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

config.native_macos_fullscreen_mode = true
config.keys = {
	-- Make Option-Left and Option-Right not retarded on macOS. Now that key combo jumps word left or right
	--
	-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
	-- { key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
	-- Make Option-Right equivalent to Alt-f; forward-word
	-- { key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
	--
	{
		key = "LeftArrow",
		mods = "OPT",
		action = wezterm.action.SendKey({ key = "b", mods = "ALT" }),
	},
	{
		key = "RightArrow",
		mods = "OPT",
		action = wezterm.action.SendKey({ key = "f", mods = "ALT" }),
	},
	{
		key = "|",
		mods = "CMD|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "CMD|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "p",
		mods = "CMD",
		action = wezterm.action.PaneSelect({
			alphabet = "1234567890",
		}),
	},
	{
		key = "p",
		mods = "CMD|SHIFT",
		action = wezterm.action.ActivateCommandPalette,
	},
	{
		key = "r",
		mods = "CMD",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
}

--   Puts tabs in macOS native top menu bar
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

return config
