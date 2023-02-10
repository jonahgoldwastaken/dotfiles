local wezterm = require("wezterm")

local config = {
	enable_kitty_keyboard = true,
	use_ime = false,
	inactive_pane_hsb = {
		saturation = 0.8,
		brightness = 0.75,
	},
	prefer_egl = true,
	alternate_buffer_wheel_scroll_speed = 0,
	front_end = "WebGpu",
	webgpu_power_preference = "LowPower",
}

return require("lib.table").table_merge(
	config,
	require("cfg_appearance"),
	require("cfg_fonts"),
	require("cfg_keymaps"),
	require("cfg_domains"),
	require("cfg_launch"),
	{}
)
