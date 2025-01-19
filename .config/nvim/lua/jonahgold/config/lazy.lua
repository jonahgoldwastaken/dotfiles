local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
local icons = require "jonahgold.util.icons"
local util = require "jonahgold.util"

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
			import = "jonahgold.plugins",
		},
		{
			import = "jonahgold.work.plugins",
			enabled = util.in_work_dir,
		},
	},
	defaults = { lazy = true },
	install = {
		missing = true,
		colorscheme = { "github-nvim-theme" },
	},
	dev = {
		path = "~/personal",
		patterns = { "jonahgoldwastaken" },
	},
	ui = {
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
	checker = {
		enabled = true,
		notify = false,
	},
	performance = {
		cache = { enabled = true },
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
}

require("lazy").setup(opts)
