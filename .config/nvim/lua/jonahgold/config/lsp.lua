local mason_registry = require "mason-registry"
local lspconfig_util = require "lspconfig.util"

local M = {}

---@return table<string>
M.lsp_clients = function()
	local clients = {}
	local installed_packages = mason_registry.get_installed_package_names()

	for _, pkg_spec in ipairs(mason_registry.get_all_package_specs()) do
		if not vim.tbl_contains(installed_packages, pkg_spec.name) then goto continue end

		local lspconfig = vim.tbl_get(pkg_spec, "neovim", "lspconfig")
		if lspconfig then table.insert(clients, lspconfig) end

		::continue::
	end

	return clients
end

---@type table<string, vim.lsp.Config>
M.custom_configs = {
	ts_ls = {
		init_options = {
			preferences = { importModuleSpecifierPreference = "non-relative" },
		},
	},
	lua_ls = {
		single_file_support = true,
		settings = {
			Lua = {
				workspace = { checkThirdParty = true },
				completion = { workspaceWord = false },
				telemetry = { enable = false },
			},
		},
	},
	yamlls = {
		settings = {
			yaml = {
				keyOrdering = false,
				customTags = { "!reference sequence" },
			},
		},
	},
	rust_analyzer = {
		{
			settings = {
				["rust-analyzer"] = {
					cargo = { allFeatures = true },
					check = { command = "clippy", extraArgs = { "--no-deps" } },
				},
			},
			on_init = function(new_client, _) new_client.offset_encoding = "utf-16" end,
		},
	},
	emmet_ls = {
		filetypes = {
			"html",
			"css",
			"javascriptreact",
			"typescriptreact",
			"handlebars",
		},
	},
	eslint = {
		filetypes = {
			"json",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
		},
		{ settings = { run = "onSave" } },
	},
	gopls = {
		root_dir = lspconfig_util.root_pattern { "go.mod" },
	},
	jsonls = {
		settings = {
			json = {
				schemas = require("schemastore").json.schemas {
					extra = {
						{
							description = "Common definition schema.",
							fileMatch = {
								"*ApiObject.json",
								"*Workflow.json",
								"*Component.json",
								"*View.json",
								"*Store.json",
							},
							name = "bunq common",
							url = "file:///Users/jonah/work/frontend/develop/bunq/common/generator/schema/SchemaCommon.json",
						},
						{
							description = "Definition file for generating bunq API Objects.",
							fileMatch = { "*ApiObject.json" },
							name = "API Object definition",
							url = "file:///Users/jonah/work/frontend/develop/bunq/common/generator/schema/SchemaApiObject.json",
						},
						{
							description = "Definition file for generating bunq Components.",
							fileMatch = { "*Component.json", "*View.json" },
							name = "Component definition",
							url = "file:///Users/jonah/work/frontend/develop/bunq/common/generator/schema/SchemaComponent.json",
						},
						{
							description = "Definition file for generating bunq Workflows.",
							fileMatch = { "*Workflow.json" },
							name = "Workflow definition",
							url = "file:///Users/jonah/work/frontend/develop/bunq/common/generator/schema/SchemaWorkflow.json",
						},
						{
							description = "Definition file for generating bunq Stores.",
							fileMatch = { "*Store.json" },
							name = "Store definition",
							url = "file:///Users/jonah/work/frontend/develop/bunq/common/generator/schema/SchemaStore.json",
						},
					},
				},
				format = { enable = false, keepLines = false },
				validate = { enable = true },
			},
		},
	},
}

return M
