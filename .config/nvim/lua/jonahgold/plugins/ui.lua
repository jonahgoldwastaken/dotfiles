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
			on_attach = function(bufnr)
				local gitsigns = require "gitsigns"

				local function map(mode, keymap, action, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, keymap, action, opts)
				end

				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal { "]h", bang = true }
					else
						gitsigns.nav_hunk "next"
					end
				end)

				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal { "[h", bang = true }
					else
						gitsigns.nav_hunk "prev"
					end
				end)

				-- Actions
				map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage Hunk" })
				map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset Hunk" })

				map(
					"v",
					"<leader>hs",
					function() gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" } end,
					{ desc = "Stage Hunk" }
				)

				map(
					"v",
					"<leader>hr",
					function() gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" } end,
					{ desc = "Stage Hunk" }
				)

				map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage Buffer" })
				map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset Buffer" })
				map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview Hunk" })
				map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview Hunk (inline)" })

				map(
					"n",
					"<leader>hb",
					function() gitsigns.blame_line { full = true } end,
					{ desc = "Blame Line" }
				)

				map("n", "<leader>hd", gitsigns.diffthis, { desc = "Open Diff" })

				map("n", "<leader>hD", function() gitsigns.diffthis "~" end, { desc = "Open Diff" })

				map(
					"n",
					"<leader>hQ",
					function() gitsigns.setqflist "all" end,
					{ desc = "Set All Hunks In QFList" }
				)
				map("n", "<leader>hq", gitsigns.setqflist, { desc = "Set Current Hunk in QFList" })

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
			end,
		},
	},
}
