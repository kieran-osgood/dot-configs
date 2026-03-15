-- Reference materials:
-- - https://github.com/letieu/dotfiles/blob/master/dot_config/wezterm/wezterm.lua
--

local wezterm = require("wezterm")
local config = wezterm.config_builder()

local mux = wezterm.mux

config.enable_scroll_bar = true

-- Tabs
config.use_fancy_tab_bar = false
config.native_macos_fullscreen_mode = true
-- Allows tabs to auto resize after renaming
config.tab_max_width = 500

-- Font
config.font_size = 16
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

config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = true

-- Window
config.window_decorations = "RESIZE"

config.window_background_opacity = 0.8
config.macos_window_background_blur = 40
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = false

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
	{ key = "'", mods = "CMD|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
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
	{
		key = "LeftArrow",
		mods = "CMD",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "DownArrow",
		mods = "CMD",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "UpArrow",
		mods = "CMD",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "RightArrow",
		mods = "CMD",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},

	{
		key = "RightArrow",
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},

	{
		key = "LeftArrow",
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},

	{
		key = "UpArrow",
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection("Down"),
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

wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

config.text_blink_ease_in = "EaseIn"
config.text_blink_ease_out = "EaseOut"
config.text_blink_rapid_ease_in = "Linear"
config.text_blink_rapid_ease_out = "Linear"
config.text_blink_rate = 500
config.text_blink_rate_rapid = 250

-- config.enable_tab_bar = true
-- config.hide_tab_bar_if_only_one_tab = false
-- config.show_new_tab_button_in_tab_bar = true
-- config.show_tab_index_in_tab_bar = false
-- config.show_tabs_in_tab_bar = true
-- config.switch_to_last_active_tab_when_closing_tab = false
-- config.tab_and_split_indices_are_zero_based = false
-- config.tab_bar_at_bottom = true
-- config.tab_max_width = 25
-- config.use_fancy_tab_bar = false

config.cursor_blink_ease_in = "EaseIn"
config.cursor_blink_ease_out = "EaseOut"
config.cursor_blink_rate = 500
config.default_cursor_style = "BlinkingBlock"
config.cursor_thickness = 1
config.force_reverse_video_cursor = true
config.animation_fps = 60

config.audible_bell = "SystemBeep"
config.visual_bell = {
	fade_in_function = "EaseOut",
	fade_in_duration_ms = 200,
	fade_out_function = "EaseIn",
	fade_out_duration_ms = 200,
}
config.enable_scroll_bar = true

config.hide_mouse_cursor_when_typing = true

config.text_blink_ease_in = "EaseIn"
config.text_blink_ease_out = "EaseOut"
config.text_blink_rapid_ease_in = "Linear"
config.text_blink_rapid_ease_out = "Linear"
config.text_blink_rate = 500
config.text_blink_rate_rapid = 250

wezterm.on("update-right-status", function(window, pane)
	local cells = {}

	-- Get cwd from pane
	local cwd_uri = pane:get_current_working_dir()
	local cwd = ""

	if cwd_uri then
		if type(cwd_uri) == "userdata" then
			cwd = cwd_uri.file_path
		else
			cwd_uri = cwd_uri:sub(8)
			local slash = cwd_uri:find("/")
			if slash then
				cwd = cwd_uri:sub(slash):gsub("%%(%x%x)", function(hex)
					return string.char(tonumber(hex, 16))
				end)
			end
		end
	end

	-- Get git branch
	local branch = ""
	if cwd ~= "" then
		local success, stdout, _ = wezterm.run_child_process({ "git", "-C", cwd, "rev-parse", "--abbrev-ref", "HEAD" })
		if success then
			branch = stdout:gsub("%s+", "")
		end
	end

	-- Branch in datetime slot (first), cwd in battery slot (last)
	if branch ~= "" then
		table.insert(cells, " " .. branch)
	end
	if cwd ~= "" then
		table.insert(cells, cwd)
	end

	local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

	-- Colors from datetime (#663a82) and battery (#7c5295) slots
	local colors = {
		"#663a82",
		"#7c5295",
	}

	local text_fg = "#c0c0c0"
	local elements = {}
	local num_cells = 0

	local function push(text, is_last)
		local cell_no = num_cells + 1
		table.insert(elements, { Foreground = { Color = text_fg } })
		table.insert(elements, { Background = { Color = colors[cell_no] } })
		table.insert(elements, { Text = " " .. text .. " " })
		if not is_last then
			table.insert(elements, { Foreground = { Color = colors[cell_no + 1] } })
			table.insert(elements, { Text = SOLID_LEFT_ARROW })
		end
		num_cells = num_cells + 1
	end

	while #cells > 0 do
		local cell = table.remove(cells, 1)
		push(cell, #cells == 0)
	end

	window:set_right_status(wezterm.format(elements))
end)
return config

-- return config
