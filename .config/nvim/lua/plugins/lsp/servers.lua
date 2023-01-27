return {
	rust_analyzer = {
		settings = {
			["rust-analyzer"] = {
				cargo = { allFeatures = true },
				check = { command = "clippy" },
				procMacro = { enable = true },
			},
		},
	},
	astro = {},
	tsserver = {},
	svelte = {},
	volar = {
		init_options = {
			typescript = {
				tsdk = vim.fn.stdpath "data"
					.. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
			},
		},
	},
	jsonls = {
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		},
	},
	tailwindcss = {
		root_dir = require("lspconfig.util").root_pattern(
			"tailwind.config.js",
			"tailwind.config.ts",
			"tailwind.config.cjs"
		),
	},
	sumneko_lua = {
		single_file_support = true,
		settings = {
			Lua = {
				workspace = {
					checkThirdParty = true,
				},
				completion = {
					workspaceWord = false,
				},
				telemetry = {
					enable = false,
				},
			},
		},
	},
	prismals = {},
	gopls = {},
	yamlls = {},
	taplo = {},
	html = {},
	emmet_ls = {
		filetypes = {
			"html",
			"css",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"handlebars",
		},
	},
}
