local icons = require "util.icons"

return {
    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged"
        }
    },

    -- Auto-completion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-emoji",
            "dmitmel/cmp-cmdline-history",
            "zbirenbaum/copilot-cmp",
            "LuaSnip",
        },
        opts = function()
            local cmp = require "cmp"
            local luasnip = require "luasnip"
            local compare = require "cmp.config.compare"

            return {
                preselect = cmp.PreselectMode.None,
                snippet = {
                    expand = function(args) luasnip.lsp_expand(args.body) end,
                },
                sources = cmp.config.sources {
                    { name = "copilot", max_item_count = 3 },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "emoji" }
                },
                mapping = cmp.mapping.preset.insert {
                    ["<esc>"] = cmp.mapping(function(fallback)
                        if not cmp.visible() then return fallback() end
                        cmp.abort()
                    end, { "s" }),
                    ["<C-Space>"] = cmp.mapping.complete { config = { completion = { keyword_length = 0 } } },
					["<C-b>"] = cmp.mapping.scroll_docs(-1),
					["<C-f>"] = cmp.mapping.scroll_docs(1),
					["<CR>"] = cmp.mapping.confirm { select = false, behavior = cmp.ConfirmBehavior.Replace },
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							return cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							return luasnip.expand_or_jump()
                        end
                        fallback()
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							return cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							return luasnip.jump(-1)
						end
                        fallback()
					end, { "i", "s" }),
                },
				formatting = {
					fields = { "abbr", "kind" },
					format = function(entry, vim_item)
						if icons.kind[vim_item.kind] then
							vim_item.kind = icons.kind[vim_item.kind] .. vim_item.kind
						end
						if entry.source.name == "copilot" then
							vim_item.kind = icons.git.Copilot .. vim_item.kind
						end
						return vim_item
					end,
				},
                completion = {
                    keyword_length = 1
                },
                window = {
                    completion = {
                        cursorline = true,
                        border = "rounded",
						winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                    },
                },
				experimental = {
					ghost_text = {
						hl_group = "LspCodeLens",
					},
				},
            }
        end
    },

    -- Auto pairs
    {
        "echasnovski/mini.pairs",
        event = { "BufReadPost", "BufNewFile" },
        main = "mini.pairs",
        config = true,
    },

    -- Surrounding
    {
        "echasnovski/mini.surround",
        keys = { "s" },
        main = "mini.surround",
        config = true,
    },

    -- Rename symbols
    {
        "smjonas/inc-rename.nvim",
        cmd = "IncRename",
        config = true,
    },

    -- Better comments
    {
        "echasnovski/mini.comment",
        event = { "BufReadPost", "BufNewFile" },
        main = "mini.comment",
        config = true,
    },

    -- Better line split/joins
	{
		"echasnovski/mini.splitjoin",
		event = { "BufReadPost", "BufNewFile" },
		main = "mini.splitjoin",
		config = true,
	},

    -- Code operations
    {
        "echasnovski/mini.operators",
        event = { "BufReadPost", "BufNewFile" },
        main = "mini.operators",
        config = true,
    },

    -- Refactoring code
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
        config = true,
	},
}
