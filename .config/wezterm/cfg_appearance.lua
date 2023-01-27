local wezterm = require("wezterm")

local cfg = {
	-- Tab bar config
	hide_tab_bar_if_only_one_tab = true,
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	tab_max_width = 24,
	show_new_tab_button_in_tab_bar = false,

	-- Cursor config
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",

	-- Window config
	window_padding = {
		left = "0",
		right = "0",
		top = "0",
		bottom = "0.5cell",
	},
	window_frame = {
		font = wezterm.font({ family = "JetBrains Mono Bold" }),
	},

	-- Other
	animation_fps = 1,
}

wezterm.on("window-config-reloaded", function(window)
	local overrides = window:get_config_overrides() or {}
	local appearance = window:get_appearance()
	local color_scheme = require("cfg_utils").scheme_for_appearance(appearance)
	if overrides.color_scheme ~= color_scheme then
		overrides.color_scheme = color_scheme
		if appearance == "Dark" then
			overrides.set_environment_variables = { os_theme = "dark" }
		else
			overrides.set_environment_variables = { os_theme = "light" }
		end
		window:set_config_overrides(overrides)
	end
end)

-- Theme options
cfg.color_scheme = require("cfg_utils").scheme_for_appearance(wezterm.gui.get_appearance())

return cfg
