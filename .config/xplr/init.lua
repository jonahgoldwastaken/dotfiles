version = "0.20.2"
---@diagnostic disable
local xplr = xplr -- The globally exposed configuration to be overridden.
---@diagnostic enable

local home = os.getenv("HOME")
package.path = home .. "/.config/xplr/plugins/?/init.lua;" .. home .. "/.config/xplr/plugins/?.lua;" .. package.path

xplr.config.general.enable_mouse = false
xplr.config.general.initial_layout = "no_help_no_selection"

require("zoxide").setup()

return {
	on_load = {},
	on_directory_change = {},
	on_focus_change = {},
	on_mode_switch = {},
	on_layout_switch = {},
}
