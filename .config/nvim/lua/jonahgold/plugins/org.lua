return {
	"nvim-neorg/neorg",
	dependencies = {
		"vhyrro/luarocks.nvim",
		"nvim-lua/plenary.nvim",
	},
	cmd = "Neorg",
	ft = "norg",
	opts = {
		load = {
			["core.defaults"] = {},
			["core.concealer"] = {},
			["core.dirman"] = {
				config = {
					workspaces = {
						notes = "~/notes",
					},
					default_workspace = "notes",
				},
			},
			["core.completion"] = {
				config = {
					engine = "nvim-cmp",
				},
			},
			["core.presenter"] = {
				config = {
					["zen_mode"] = "zen-mode",
				},
			},
			["core.export"] = {},
			["core.export.markdown"] = {},
		},
	},
}
