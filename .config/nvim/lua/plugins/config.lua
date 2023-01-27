local function load(name)
	local Util = require "lazy.core.util"
	-- always load lazyvim, then user file
	local mod = "config." .. name
	Util.try(function() require(mod) end, {
		msg = "Failed loading " .. mod,
	})
end

-- load options here, before lazy init while sourcing plugin modules
-- this is needed to make sure options will be correctly applied
-- after installing missing plugins
load "options"

-- autocmds and keymaps can wait to load
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		load "autocmds"
		load "keymaps"
	end,
})

return {}
