-- Reference materials:
-- - https://github.com/letieu/dotfiles/blob/master/dot_config/wezterm/wezterm.lua
--

local wezterm = require("wezterm")
local config = wezterm.config_builder()
local mux = wezterm.mux

-- Tabs
config.use_fancy_tab_bar = false
config.native_macos_fullscreen_mode = true
-- Allows tabs to auto resize after renaming
config.tab_max_width = 500

-- Font
config.font_size = 9
config.font = wezterm.font("JetBrains Mono")

-- Color
local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		-- config.color_scheme = "AdventureTime"
		return "Catppuccin Frappe"
	else
		return "Catppuccin Frappe"
		-- return "Catppuccin Latte" // maybe it hurts my brain
	end
end

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

-- Window
config.window_decorations = "RESIZE"

config.window_background_opacity = 0.8
config.macos_window_background_blur = 40
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = "0px",
}
--
wezterm.on("gui-startup", function()
	---@diagnostic disable-next-line: unused-local
	local tab, _, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

config.keys = {
	{ key = "LeftArrow", mods = "OPT", action = wezterm.action.SendKey({ key = "b", mods = "ALT" }) },
	{ key = "RightArrow", mods = "OPT", action = wezterm.action.SendKey({ key = "f", mods = "ALT" }) },
	{ key = "|", mods = "CMD|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "CMD|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
	{ key = "p", mods = "CMD", action = wezterm.action.PaneSelect({ alphabet = "1234567890" }) },
	{ key = "p", mods = "CMD|SHIFT", action = wezterm.action.ActivateCommandPalette },
	{
		mods = "CMD",
		key = "r",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	-- {
	-- 	mods = "CMD",
	-- 	key = ",",
	-- 	action = wezterm.action.SpawnCommandInNewTab({
	-- 		cwd = os.getenv("WEZTERM_CONFIG_DIR"),
	-- 		args = { os.getenv("SHELL"), "-c", "$EDITOR $WEZTERM_CONFIG_FILE" },
	-- 	}),
	-- },
}

for i = 1, 8 do
	-- CTRL+ALT + number to move to that position
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL|ALT",
		action = wezterm.action.MoveTab(i - 1),
	})
end

return config
