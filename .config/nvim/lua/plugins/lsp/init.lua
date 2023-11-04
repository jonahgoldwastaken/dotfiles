local icons = require "util.icons"

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			{ "folke/neodev.nvim", config = true },
			{
				"williamboman/mason-lspconfig.nvim",
				dependencies = { "mason.nvim" },
				opts = {
					ensure_installed = {
						"tsserver",
						"jsonls",
						"yamlls",
						"taplo",
						"html",
						"emmet_ls",
						"tailwindcss",
						"lua_ls",
						"eslint",
						"svelte",
						"astro",
						"gopls",
					},
				},
			},
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("util").on_attach(function(client, buffer)
				require("plugins.lsp.format").on_attach(client, buffer)
				require("plugins.lsp.keymaps").on_attach(client, buffer)
			end)

			-- diagnostics
			for name, icon in pairs(icons.diagnostics) do
				name = "DiagnosticSign" .. name
				vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
			end

			vim.diagnostic.config {
				underline = true,
				virtual_text = { spacing = 4, prefix = icons.ui.FilledCircle },
				severity_sort = true,
			}

			local servers = require "plugins.lsp.servers"
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			for server, opts in pairs(servers) do
				opts.capabilities = capabilities
				require("lspconfig")[server].setup(opts)
			end
		end,
	},

	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {
			PATH = "prepend",
			ui = {
				keymaps = {
					toggle_server_expand = "<CR>",
					install_server = "i",
					update_server = "u",
					check_server_version = "c",
					update_all_servers = "U",
					check_outdated_servers = "C",
					uninstall_server = "X",
				},
				check_outdated_servers_on_open = true,
			},
			log_level = vim.log.levels.INFO,
		},
	},

	"b0o/schemastore.nvim",

	{
		"stevearc/conform.nvim",
		event = { "BufNewFile", "BufReadPre" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				css = { "prettierd" },
				javascriptreact = { "prettierd" },
				javascript = { "prettierd" },
				typescriptreact = { "prettierd" },
				typescript = { "prettierd" },
				rust = { "rustfmt" },
				markdown = { "prettierd" },
			},
		},
	},
}
