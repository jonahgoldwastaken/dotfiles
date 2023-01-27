local function set_color_scheme()
	local dark_mode = vim.fn.system "defaults read -g AppleInterfaceStyle 2>/dev/null"
	if dark_mode:find "Dark" then
		vim.opt.background = "dark"
	else
		vim.opt.background = "light"
	end
end

return {
	{
		"jonahgoldwastaken/octocolors.nvim",
		lazy = false,
		priority = 1000,
		dev = true,
		config = function()
			vim.api.nvim_create_user_command("AutoDarkMode", set_color_scheme, { nargs = 0 })

			vim.opt.background = vim.env.os_theme or "dark"

			local octocolors = require "octocolors"
			octocolors.setup {
				sidebars = { "lazy", "neo-tree", "qf", "vista_kind", "help" },
			}
			octocolors.load()
		end,
	},
}
