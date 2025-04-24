return {
	-- More and better text-object navigation
	{
		"echasnovski/mini.ai",
		keys = {
			{ "a", mode = { "x", "o" } },
			{ "i", mode = { "x", "o" } },
		},
		main = "mini.ai",
		opts = function()
			local ai = require "mini.ai"
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter { -- code block
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					},
					f = ai.gen_spec.treesitter { a = "@function.outer", i = "@function.inner" }, -- function
					c = ai.gen_spec.treesitter { a = "@class.outer", i = "@class.inner" }, -- class
					t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
					d = { "%f[%d]%d+" }, -- digits
					e = { -- Word with case
						{
							"%u[%l%d]+%f[^%l%d]",
							"%f[%S][%l%d]+%f[^%l%d]",
							"%f[%P][%l%d]+%f[^%l%d]",
							"^[%l%d]+%f[^%l%d]",
						},
						"^().*()$",
					},
					u = ai.gen_spec.function_call(), -- u for "Usage"
					U = ai.gen_spec.function_call { name_pattern = "[%w_]" }, -- without dot in function name
				},
			}
		end,
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

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = false,
		priority = 49,
		config = function()
			-- When in diff mode, we want to use the default
			-- vim text objects c & C instead of the treesitter ones.
			local move = require "nvim-treesitter.textobjects.move" ---@type table<string,fun(...)>
			local configs = require "nvim-treesitter.configs"
			for name, fn in pairs(move) do
				if name:find "goto" == 1 then
					move[name] = function(q, ...)
						if vim.wo.diff then
							local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
							for key, query in pairs(config or {}) do
								if q == query and key:find "[%]%[][cC]" then
									vim.cmd("normal! " .. key)
									return
								end
							end
						end
						return fn(q, ...)
					end
				end
			end
		end,
	},
}
