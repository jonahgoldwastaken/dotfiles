return {
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
		"fladson/vim-kitty",
		ft = "kitty",
	},

	{
		"imsnif/kdl.vim",
		ft = "kdl",
	},

	{
		"ojroques/nvim-osc52",
		event = "BufReadPost",
		config = function()
			local function copy()
				if vim.v.event.operator == "y" and vim.v.event.regname == "+" then
					require("osc52").copy_register "+"
				end
			end

			vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
		end,
	},
}
