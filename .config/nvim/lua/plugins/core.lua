local icons = require "util.icons"

return {
    -- Plugin manager
    { "folke/lazy.nvim", version = false },

    -- Colorscheme
    {
        "projekt0n/github-nvim-theme",
        lazy = false,
        priority = 1000,
        main = "github-theme",
        init = function()
            vim.o.background = vim.env.os_theme or "dark"
        end,
        opts = {
            darken = {
                floats = true
            }
        },
        config = function(_, opts)
            require "github-theme".setup(opts)

            if vim.o.background == "dark" then
                vim.cmd "colorscheme github_dark_high_contrast"
            else
                vim.cmd "colorscheme github_light_high_contrast"
            end
        end
    },

    -- Splash screen
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = { "nvim-web-devicons" },
        opts = function()
			local dashboard = require "alpha.themes.dashboard"
			dashboard.section.buttons.val = {
				dashboard.button("f", icons.ui.Search .. " Find file", ":Telescope find_files <CR>"),
				dashboard.button(
					"n",
					icons.documents.NewFile .. " New file",
					":ene <BAR> startinsert <CR>"
				),
				dashboard.button("r", icons.ui.History .. " Recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("g", icons.ui.Telescope .. " Find text", ":Telescope live_grep <CR>"),
				dashboard.button("c", icons.ui.Gear .. " Config", ":e $MYVIMRC <CR>"),
				dashboard.button(
					"s",
					icons.ui.History .. " Restore Session",
					[[:lua require("persistence").load() <cr>]]
				),
				dashboard.button("m", icons.misc.Package .. " Mason", ":Mason<CR>"),
				dashboard.button("l", icons.misc.Sleep .. " Lazy", ":Lazy<CR>"),
				dashboard.button("q", icons.ui.SignOut .. " Quit", ":qa<CR>"),
			}
			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end
			dashboard.section.footer.opts.hl = "Type"
			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.buttons.opts.hl = "AlphaButtons"
			dashboard.opts.layout[1].val = 8
			vim.b.miniindentscope_disable = true

			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
				callback = function() require("lazy").show() end,
				})
			end

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					dashboard.section.footer.val = icons.ui.Fire
						.. " Neovim loaded "
						.. stats.count
						.. " plugins in "
						.. ms
						.. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})

            return dashboard.opts
        end
	},
}
