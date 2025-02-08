return {
	-- More and better text-object navigation
	{
		"echasnovski/mini.ai",
		keys = {
			{ "a", mode = { "x", "o" } },
			{ "i", mode = { "x", "o" } },
		},
		main = "mini.ai",
		opts = {
			n_lines = 500,
		},
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		lazy = false,
		init = function(plugin)
			require("lazy.core.loader").add_to_rtp(plugin)
			require "nvim-treesitter.query_predicates"
		end,
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup {
				auto_install = true,
				sync_install = false,
				ensure_installed = {
					"astro",
					"bash",
					"c",
					"css",
					"fish",
					"go",
					"gomod",
					"git_config",
					"gitcommit",
					"gitignore",
					"html",
					"javascript",
					"json",
					"json5",
					"jsonc",
					"kdl",
					"lua",
					"markdown",
					"markdown_inline",
					"php",
					"rust",
					"scss",
					"svelte",
					"toml",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
					"vue",
					"yaml",
				},
				highlight = { enable = true },
				indent = { enable = true },
				context_commentstring = { enable = true, enable_autocmd = false },
			}
		end,
	},
}
