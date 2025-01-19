local icons = require "jonahgold.util.icons"

return {
	-- Auto-completion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"shurensha/cmp-path",
			"hrsh7th/cmp-emoji",
		},
		opts = function()
			local cmp = require "cmp"

			return {
				preselect = cmp.PreselectMode.Item,
				snippet = {
					expand = function(args) vim.snippet.expand(args.body) end,
				},
				sources = cmp.config.sources {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "emoji" },
				},
				mapping = cmp.mapping.preset.insert {
					["<Tab>"] = cmp.mapping(function(fallback)
						if vim.snippet.active { direction = 1 } then
							vim.snippet.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if vim.snippet.active { direction = -1 } then
							vim.snippet.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
					["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
					["<C-Space>"] = cmp.mapping.complete { config = { completion = { keyword_length = 0 } } },
					["<C-b>"] = cmp.mapping.scroll_docs(-1),
					["<C-f>"] = cmp.mapping.scroll_docs(1),
					["<C-y>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace },
					["<ESC>"] = cmp.mapping(function(fallback)
						if cmp.visible() then cmp.abort() end
						fallback()
					end, { "i", "s" }),
				},
				formatting = {
					fields = { "abbr", "kind" },
					format = function(_, vim_item)
						if icons.kind[vim_item.kind] then
							vim_item.kind = icons.kind[vim_item.kind] .. vim_item.kind
						end
						return vim_item
					end,
				},
			}
		end,
	},

	-- Surrounding
	{
		"echasnovski/mini.surround",
		keys = { "s" },
		main = "mini.surround",
		opts = {
			n_lines = 500,
		},
	},

	-- Better comments
	{
		"echasnovski/mini.comment",
		event = { "BufReadPost", "BufNewFile" },
		main = "mini.comment",
		config = true,
	},

	-- Better line split/joins
	{
		"echasnovski/mini.splitjoin",
		event = { "BufReadPost", "BufNewFile" },
		main = "mini.splitjoin",
		config = true,
	},

	-- Code operations
	{
		"echasnovski/mini.operators",
		event = { "BufReadPost", "BufNewFile" },
		main = "mini.operators",
		config = true,
	},
}
