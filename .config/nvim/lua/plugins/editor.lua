local util = require "util"
local icons = require "util.icons"

return {
    -- File explorer
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-web-devicons" },
        config = true,
        cmd = "Oil",
        keys = {
            { "<leader>e", "<cmd>Oil<cr>", "n" }
        }
    },

    -- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
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
				},
			}
			telescope.load_extension "fzf"
			telescope.load_extension "noice"
		end,
	},

    -- Bracket navigation
	{
		"echasnovski/mini.bracketed",
		event = { "BufReadPost", "BufNewFile" },
		main = "mini.bracketed",
		config = true,
	},

    -- Line navigation preview
	{ "nacro90/numb.nvim", event = { "BufReadPost", "BufNewFile" }, config = true },

    -- File tagging
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

    -- Buffer management
	{
		"axkirillov/hbac.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		event = "VeryLazy",
        config = true
	},

    -- Better quickfix list
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		keys = {
			{
				"<leader>xx",
				"<cmd>TroubleToggle<cr>",
				desc = "Toggle Trouble",
			},
			{
				"<leader>xw",
				"<cmd>TroubleToggle workspace_diagnostics<cr>",
				desc = "Workspace Diagnostics (Trouble)",
			},
			{
				"<leader>xq",
				"<cmd>TroubleToggle quickfix<cr>",
				desc = "Quickfix (Trouble)",
			},
			{
				"<leader>xl",
				"<cmd>TroubleToggle loclist<cr>",
				desc = "Location list (Trouble)",
			},
		},
		opts = { auto_open = false, use_diagnostic_signs = true },
	},

    -- WhichKey
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
					filetypes = { "TelescopePrompt", "lazy", "mason" },
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
				["<leader>w"] = { name = "+windows" },
				["<leader>x"] = { name = "+diagnostics/quickfix" },
			}
		end,
	},
}
