local icons = require "jonahgold.util.icons"
local settings = require "jonahgold.config.settings"

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
					statusline = { "lazy", "TelescopePrompt" },
				},
			},
			extensions = { "lazy", "mason", "trouble" },
			sections = {
				lualine_a = { { "mode", fmt = function(str) return str:sub(1, 1) end } },
				lualine_b = {
					{
						function()
							local cwd = vim.uv.cwd()
							if cwd == nil then return "" end

							local t = {}
							for part in cwd:gmatch "/(%w+)" do
								t:insert(part)
							end
							return t[#t]
						end,
					},
				},
				lualine_c = { "filename" },
				lualine_x = {
					{
						"diagnostics",
						source = { "nvim_diagnostic" },
						always_visible = true,
						symbols = { error = "E", warn = " W", info = " I", hint = " H" },
						separator = " ",
					},
				},
				lualine_y = {
					{
						"fileformat",
						symbols = {
							unix = "lf",
							dos = "crlf",
							mac = "cr",
						},
					},
					function() return vim.bo.filetype end,
					function()
						if settings.autoformat then
							return "format"
						else
							return "noformat"
						end
					end,
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
				group = "Jonahgold",
				pattern = { "help", "Trouble", "lazy", "mason", "norg" },
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
