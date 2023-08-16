local util = require "util"
local icons = require "config.icons"

return {
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "Oil",
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
			"debugloop/telescope-undo.nvim",
			"nvim-web-devicons",
		},
		cmd = "Telescope",
		keys = {
			{
				"<leader>ff",
				util.telescope "files",
				desc = "Find files (root dir)",
			},
			{
				"<leader>fF",
				util.telescope("files", { cwd = false }),
				desc = "Find files (cwd)",
			},
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
			{
				"<leader>/",
				"<cmd>Telescope current_buffer_fuzzy_find<cr>",
				desc = "Search text in buffer",
			},
			{
				"<leader>sb",
				"<cmd>Telescope current_buffer_fuzzy_find<cr>",
				desc = "Search text in buffer",
			},
			{ "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
			{ "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Grep (root dir)" },
			{ "<leader>xd", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
			{
				"<leader>ss",
				util.telescope("lsp_document_symbols", {
					symbols = {
						"Class",
						"Constructor",
						"Enum",
						"Field",
						"Function",
						"Interface",
						"Method",
						"Module",
						"Property",
						"Struct",
						"Trait",
					},
				}),
				desc = "Goto Symbol",
			},
			{
				"<leader>sw",
				util.telescope("lsp_workspace_symbols", {
					symbols = {
						"Class",
						"Constructor",
						"Enum",
						"Field",
						"Function",
						"Interface",
						"Method",
						"Property",
						"Struct",
						"Trait",
					},
				}),
				desc = "Goto Symbol (workspace)",
			},
			{ "<leader>su", "<cmd>Telescope undo<cr>", desc = "Undo tree" },
			{ "<leader>ha", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
			{ "<leader>hc", "<cmd>Telescope commands<cr>", desc = "Commands" },
			{ "<leader>hf", "<cmd>Telescope filetypes<cr>", desc = "File Types" },
			{ "<leader>hh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
			{ "<leader>hk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
			{ "<leader>hm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
			{ "<leader>ho", "<cmd>Telescope vim_options<cr>", desc = "Options" },
			{ "<leader>hs", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
			{ "<leader>ht", "<cmd>Telescope builtin<cr>", desc = "Telescope" },
		},
		config = function()
			local telescope = require "telescope"
			telescope.setup {
				defaults = {
					layout_strategy = "horizontal",
					layout_config = {
						prompt_position = "top",
						center = {
							anchor = "N",
							width = 80,
						},
					},
					sorting_strategy = "ascending",
					winblend = 0,
					color_devicons = false,
					prompt_prefix = icons.chevron.Right,
					selection_caret = icons.triangle.Right,
					mappings = {
						i = {
							["<C-u>"] = false,
							["<C-d>"] = false,
							["<c-t>"] = function(...)
								return require("trouble.providers.telescope").open_with_trouble(...)
							end,
							["<C-i>"] = function() util.telescope("find_files", { no_ignore = true })() end,
							["<C-h>"] = function() util.telescope("find_files", { hidden = true })() end,
							["<C-Down>"] = function(...)
								return require("telescope.actions").cycle_history_next(...)
							end,
							["<C-Up>"] = function(...)
								return require("telescope.actions").cycle_history_prev(...)
							end,
						},
					},
					preview = {
						treesitter = true,
					},
				},
				pickers = {
					current_buffer_fuzzy_find = {
						wrap_results = false,
						theme = "dropdown",
					},
					find_files = {
						previewer = false,
						layout_strategy = "center",
					},
					git_files = {
						previewer = false,
						layout_strategy = "center",
					},
					buffers = {
						previewer = false,
						layout_strategy = "center",
					},
					lsp_references = {
						fname_width = 80,
					},
					lsp_document_symbols = {
						wrap_results = false,
						theme = "dropdown",
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
					},
					undo = {
						use_delta = true,
						side_by_side = true,
						layout_strategy = "vertical",
						layout_config = {
							preview_height = 0.8,
						},
					},
				},
			}
			telescope.load_extension "fzf"
			telescope.load_extension "noice"
			telescope.load_extension "undo"
		end,
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			local wk = require "which-key"
			wk.setup {
				plugins = { spelling = true },
				key_labels = { ["<leader>"] = "SPC" },
				disable = {
					buftypes = {},
					filetypes = { "TelescopePrompt", "NvimTree", "neo-tree", "lazy", "mason" },
				},
			}
			wk.register {
				mode = { "n", "v" },
				["g"] = { name = "+goto" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				["<leader><tab>"] = { name = "+tabs" },
				["<leader>b"] = { name = "+buffer" },
				["<leader>c"] = { name = "+code" },
				["<leader>d"] = { name = "+dap" },
				["<leader>e"] = { name = "+explorer" },
				["<leader>f"] = { name = "+file" },
				["<leader>g"] = { name = "+git" },
				["<leader>h"] = { name = "+help" },
				["<leader>n"] = { name = "+noice" },
				["<leader>q"] = { name = "+quit/session" },
				["<leader>s"] = { name = "+search" },
				["<leader>t"] = { name = "+tag" },
				["<leader>u"] = { name = "+undo" },
				["<leader>w"] = { name = "+windows" },
				["<leader>x"] = { name = "+diagnostics/quickfix" },
			}
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("gitsigns").setup {
				signs = {
					add = {
						hl = "GitSignsAdd",
						text = "│",
						numhl = "GitSignsAddNr",
						linehl = "GitSignsAddLn",
					},
					change = {
						hl = "GitSignsChange",
						text = "│",
						numhl = "GitSignsChangeNr",
						linehl = "GitSignsChangeLn",
					},
					delete = {
						hl = "GitSignsDelete",
						text = "_",
						numhl = "GitSignsDeleteNr",
						linehl = "GitSignsDeleteLn",
					},
					topdelete = {
						hl = "GitSignsDelete",
						text = "‾",
						numhl = "GitSignsDeleteNr",
						linehl = "GitSignsDeleteLn",
					},
					changedelete = {
						hl = "GitSignsChange",
						text = "~",
						numhl = "GitSignsChangeNr",
						linehl = "GitSignsChangeLn",
					},
				},
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 1000,
					ignore_whitespace = false,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil, -- Use default
				max_file_length = 40000,
				preview_config = {
					-- Options passed to nvim_open_win
					border = "rounded",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
			}
		end,
	},

	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		keys = {
			{
				"<leader>xx",
				"<cmd>TroubleToggle workspace_diagnostics<cr>",
				desc = "Document Diagnostics (Trouble)",
			},
		},
		opts = { auto_open = false, use_diagnostic_signs = true },
	},

	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("illuminate").configure {
				delay = 200,
				filetypes_allowlist = {
					"javascript",
					"javascriptreact",
					"go",
					"rust",
					"typescript",
					"typescriptreact",
					"vue",
					"svelte",
					"lua",
				},
			}
		end,
        -- stylua: ignore
        keys = {
            { "]]", function() require("illuminate").goto_next_reference(false) end, desc = "Next Reference", },
            { "[[", function() require("illuminate").goto_prev_reference(false) end, desc = "Prev Reference" },
        },
	},

	{ "nacro90/numb.nvim", event = { "BufReadPost", "BufNewFile" }, config = true },

	{
		"ThePrimeagen/refactoring.nvim",
		keys = {
			{
				"<leader>r",
				function() require("refactoring").select_refactor() end,
				mode = "v",
				noremap = true,
				silent = true,
				expr = false,
			},
		},
		opts = {},
	},

	{
		"echasnovski/mini.bracketed",
		event = { "BufReadPost", "BufNewFile" },
		main = "mini.bracketed",
		config = true,
	},

	{
		"cbochs/grapple.nvim",
		keys = {
			{
				"<leader>tt",
				function() require("grapple").toggle() end,
				desc = "Toggle tag",
				noremap = true,
			},
			{
				"<leader>ts",
				function() require("grapple").tag() end,
				desc = "Set tag",
				noremap = true,
			},
			{
				"<leader>td",
				function() require("grapple").untag() end,
				desc = "Untag",
				noremap = true,
			},
			{
				"<leader>tT",
				function()
					require("grapple").toggle {
						key = vim.fs.basename(vim.api.nvim_buf_get_name(0)),
					}
				end,
				desc = "Toggle tag (named)",
				noremap = true,
			},
			{
				"<leader>tS",
				function()
					require("grapple").tag {
						key = vim.fs.basename(vim.api.nvim_buf_get_name(0)),
					}
				end,
				desc = "Set tag (named)",
				noremap = true,
			},
			{
				"<leader>tD",
				function()
					require("grapple").untag {
						key = vim.fs.basename(vim.api.nvim_buf_get_name(0)),
					}
				end,
				desc = "Untag (named)",
				noremap = true,
			},
			{
				"<leader>tn",
				"<cmd>GrappleCycle forward<cr>",
				desc = "Next tag",
				noremap = true,
			},
			{
				"<leader>tp",
				"<cmd>GrappleCycle backward<cr>",
				desc = "Previous tag",
				noremap = true,
			},
			{
				"<leader>tq",
				function() require("grapple").quickfix() end,
				desc = "Quickfix",
				noremap = true,
			},
			{
				"<leader>tf",
				function() require("grapple").popup_tags() end,
				desc = "Find tags",
				noremap = true,
			},
			{
				"<leader>tm",
				function() require("grapple").popup_scopes() end,
				desc = "Find scopes",
				noremap = true,
			},
		},
		opts = {
			log_level = "warn",
			scope = "git",
			popup_options = {
				relative = "editor",
				width = 40,
				height = 12,
				style = "minimal",
				focusable = false,
				border = "rounded",
			},
		},
	},

	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			window = {
				width = 120,
				options = {
					signcolumn = "no",
					relativenumber = false,
					number = false,
				},
			},
			plugins = {
				options = {
					enabled = true,
					ruler = true,
					showcmd = true,
					laststatus = 0,
					list = false,
				},
				twilight = { enabled = false },
				gitsigns = { enabled = true },
				kitty = {
					enabled = false,
					font = "18",
				},
			},
			on_open = function()
				vim.opt.fillchars:remove "eob:~"
				vim.o.cmdheight = 1
			end,
			on_close = function()
				vim.opt.fillchars:append "eob:~"
				vim.o.cmdheight = 0
			end,
		},
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	},

	{
		"sQVe/bufignore.nvim",
		event = "VeryLazy",
		dependencies = { "plenary.nvim" },
		opts = {
			auto_start = true,
			ignore_sources = {
				git = true,
			},
		},
	},

	{
		"axkirillov/hbac.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		event = "VeryLazy",
		config = function() require("hbac").setup() end,
	},
}
