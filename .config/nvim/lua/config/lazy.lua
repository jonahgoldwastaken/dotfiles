local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
local icons = require "config.icons"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

---@type LazyConfig
local opts = {
	spec = {
		{
			import = "plugins",
		},
	},
	defaults = { lazy = true },
	install = {
		missing = true,
		colorscheme = { "octocolors.nvim" },
	},
	dev = {
		path = "~/programmeren",
		patterns = { "jonahgoldwastaken" },
	},
	ui = {
		border = "rounded",
		icons = {
			cmd = icons.misc.Terminal,
			config = icons.ui.Gear,
			event = icons.kind.Event,
			ft = icons.documents.File,
			init = icons.ui.Gear,
			import = icons.ui.SignIn,
			keys = icons.misc.Keyboard,
			lazy = icons.misc.Sleep,
			loaded = icons.ui.FilledCircle,
			not_loaded = icons.ui.EmptyCircle,
			plugin = icons.misc.Package,
			runtime = icons.misc.Vim,
			source = icons.ui.Code,
			start = icons.dap.Start,
			task = icons.ui.Check,
			list = {
				icons.ui.EmptyCircle,
				"➜",
				"★",
				"‒",
			},
		},
	},
	checker = { enabled = false },
	performance = {
		cache = { enabled = true },
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"rplugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
}

require("lazy").setup(opts)
