local icons = require "util.icons"

return {
	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				icons_enabled = true,
				theme = "auto",
				section_separators = "",
				component_separators = { left = icons.border.Vertical, right = icons.border.Vertical },
				globalstatus = true,
				disabled_filetypes = {
					statusline = { "alpha", "lazy", "TelescopePrompt" },
				},
			},
			extensions = { "lazy", "mason", "trouble" },
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					{ "branch", icon = icons.git.Branch },
					{
						"diff",
						colored = false,
						symbols = {
							added = icons.git.Add,
							modified = icons.git.Mod,
							removed = icons.git.Remove,
						},
					},
				},
				lualine_c = {
					{ "filename", path = 1 },
				},
				lualine_x = {
					{
						function() return require("copilot_status").status_string() end,
						cnd = function() return require("copilot_status").enabled() end,
					},
					{
						"diagnostics",
						source = { "nvim_diagnostic" },
						sections = { "error", "warn" },
						always_visible = true,
						symbols = { error = icons.diagnostics.Error },
						separator = "",
					},
				},
				lualine_y = {
					"o:encoding",
					{
						"fileformat",
						symbols = {
							unix = "lf",
							dos = "crlf",
							mac = "cr",
						},
					},
					{
						"filetype",
						colored = false,
						icon = { icons.misc.File },
					},
				},
				lualine_z = {
					"searchcount",
					"location",
					{
						function() return tostring(vim.fn.wordcount().words) end,
						cond = function() return vim.bo.filetype == "markdown" end,
					},
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
		},
	},

	-- Active indent guide and indent text objects
	{
		"echasnovski/mini.indentscope",
		version = false,
		event = { "BufReadPost", "BufNewFile" },
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "Trouble", "lazy", "mason" },
				callback = function() vim.b.miniindentscope_disable = true end,
			})
		end,
		main = "mini.indentscope",
		opts = function()
			return {
				symbol = "▏",
				draw = {
					delay = 0,
					animation = require("mini.indentscope").gen_animation.none(),
				},
				options = { try_as_border = true },
			}
		end,
	},

	-- Nicer inputs and selects
	{
		"stevearc/dressing.nvim",
		config = true,
		lazy = false,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load { plugins = { "dressing.nvim" } }
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load { plugins = { "dressing.nvim" } }
				return vim.ui.input(...)
			end
		end,
	},

	-- GitSigns
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			current_line_blame = true,
			signcolumn = true,
		},
	},
}
