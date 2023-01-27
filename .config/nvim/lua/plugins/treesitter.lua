return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPre",
		config = true,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		event = "BufReadPost",
		config = function()
			require("nvim-treesitter.configs").setup {
				sync_install = false,
				auto_install = false,
				ensure_installed = {
					"bash",
					"scss",
					"css",
					"lua",
					"rust",
					"astro",
					"svelte",
					"vue",
					"javascript",
					"typescript",
					"json5",
					"json",
					"toml",
					"gomod",
					"dockerfile",
					"yaml",
					"fish",
					"tsx",
				},
				highlight = { enable = true },
				indent = { enable = true },
				context_commentstring = { enable = true, enable_autocmd = false },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = "<C-s>",
						node_decremental = "<C-bs>",
					},
				},
			}
		end,
	},
}
