local util = require "jonahgold.util"
local icons = require "jonahgold.util.icons"
local settings = require "jonahgold.config.settings"

local function format()
	if settings.autoformat then require("conform").format { timeout = 250 } end
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = "Jonahgold",
	callback = function(e)
		local buffer = e.buf
		local client = vim.lsp.get_client_by_id(e.data.client_id)

		if client ~= nil and client:supports_method "textDocument/formatting" then
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = "Jonahgold",
				buffer = buffer,
				callback = function() format() end,
			})

			vim.keymap.set("n", "<leader>cf", format, { desc = "Format Document" })
		end

		vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
		vim.keymap.set(
			"n",
			"<leader>xd",
			"<cmd>Telescope diagnostics<cr>",
			{ desc = "Telescope Diagnostics" }
		)
		vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { desc = "Goto Definition" })
		vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
		vim.keymap.set("n", "gD", "<cmd>Telescope lsp_declarations<cr>", { desc = "Goto Declarations" })
		vim.keymap.set(
			"n",
			"gI",
			"<cmd>Telescope lsp_implementations<cr>",
			{ desc = "Goto Implementations" }
		)
		vim.keymap.set(
			"n",
			"gI",
			"<cmd>Telescope lsp_type_definitions<cr>",
			{ desc = "Goto Type Definitions" }
		)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })

		if util.lsp_client_has_capability(client, "signatureHelp") then
			vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
		end

		if util.lsp_client_has_capability(client, "rename") then
			vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename Symbol" })
		end

		if util.lsp_client_has_capability(client, "codeAction") then
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
		end
	end,
})

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
			{
				"mason-org/mason.nvim",
				cmd = "Mason",
				opts = {
					PATH = "prepend",
					ui = { check_outdated_servers_on_open = true },
					log_level = vim.log.levels.INFO,
				},
			},
			"saghen/blink.cmp",
			"b0o/schemastore.nvim",
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lsp = require "jonahgold.config.lsp"

			vim.lsp.config("*", { capabilities = capabilities })

			for server_name, config in pairs(lsp.custom_configs) do
				vim.lsp.config(server_name, config)
			end

			vim.lsp.enable(lsp.lsp_clients())

			vim.diagnostic.config {
				underline = true,
				virtual_text = { spacing = 4, prefix = icons.ui.FilledCircle },
				severity_sort = true,
			}
		end,
	},

	{
		"stevearc/conform.nvim",
		event = { "BufNewFile", "BufReadPre" },
		opts = {
			formatters_by_ft = {
				astro = { "prettierd" },
				css = { "prettierd" },
				go = { "gofmt" },
				html = { "prettierd" },
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				json = { "prettierd" },
				lua = { "stylua" },
				markdown = { "prettierd" },
				rust = { "rustfmt" },
				svelte = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
			},
		},
	},
}
