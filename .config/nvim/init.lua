if vim.fn.has "nvim-0.9.0" == 1 then vim.loader.enable() end

require "config.options"

if vim.fn.argc(-1) == 0 then
	vim.api.nvim_create_autocmd("User", {
		pattern = "VeryLazy",
		callback = function()
			require "config.autocmds"
			require "config.keymaps"
		end,
	})
else
	require "config.autocmds"
	require "config.keymaps"
end

require "config.lazy"

vim.api.nvim_create_user_command(
	"Icon",
	function(args) vim.fn.setreg("i", vim.fn.nr2char(vim.fn.str2nr(args.args, 16))) end,
	{ nargs = 1 }
)

vim.api.nvim_create_user_command("Color", function(args)
	local color = args.fargs[1]
	local opacity = args.fargs[2] or 1
	local res = require("octocolors.util").alpha(
		color,
		require("octocolors.colors").get_colors().colors.bg.default,
		opacity
	)
	vim.notify(res)
	--
end, {
	nargs = "+",
})
