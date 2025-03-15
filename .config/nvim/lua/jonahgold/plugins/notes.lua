---@diagnostic disable: missing-fields
return {
	{},
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		cmd = { "ObsidianWorkspace", "ObsidianNew", "ObsidianToday" },
		keys = {
			{ "<leader>onn", "<cmd>ObsidianNew<cr>", mode = "n", desc = "New note" },
			{
				"<leader>ont",
				"<cmd>ObsidianNewFromTemplate<cr>",
				mode = "n",
				desc = "New note from template",
			},

			{ "<leader>otd", "<cmd>ObsidianToday<cr>", mode = "n", desc = "Open Today's note" },
			{ "<leader>oto", "<cmd>ObsidianToday<cr>", mode = "n", desc = "Open Tomorrow's note" },
			{ "<leader>oy", "<cmd>ObsidianYesterday<cr>", mode = "n", desc = "Open Yesterday's note" },

			{ "<leader>fn", "<cmd>ObsidianQuickSwitch<cr>", mode = "n", desc = "Find notes" },
			{ "<leader>sn", "<cmd>ObsidianSearch<cr>", mode = "n", desc = "Search note" },

			{
				"<leader>oln",
				"<cmd>ObsidianLinkNew<cr>",
				mode = "v",
				desc = "Create new link from selection",
			},
			{
				"<leader>oll",
				"<cmd>ObsidianLink<cr>",
				mode = "v",
				desc = "Create new link from selection",
			},
			{ "<leader>oe", "<cmd>ObsidianExtractNote<cr>", mode = "v", desc = "Extract to new note" },

			{
				"<leader>ob",
				"<cmd>ObsidianBacklinks<cr>",
				mode = "n",
				desc = "Open references to current note",
			},
			{ "<leader>op", "<cmd>ObsidianOpen<cr>", mode = "n", desc = "Open current note in Obsidian" },

			{ "<leader>orr", "<cmd>ObsidianRename<cr>", mode = "n", desc = "Rename note" },
			{
				"<leader>ord",
				"<cmd>ObsidianRename --dry-run<cr>",
				mode = "n",
				desc = "Rename note (dry)",
			},
		},
		event = {
			"BufReadPre " .. vim.fn.expand "~" .. "/vaults/**/*.md",
			"BufNewFile " .. vim.fn.expand "~" .. "/vaults/**/*.md",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		---@type obsidian.config.ClientOpts
		opts = {
			workspaces = {
				{
					name = "personal",
					path = "~/vaults/personal",
				},
			},

			note_id_func = function(title)
				local title_match = title:match "^%d+-%d+-%d+"

				if title_match ~= nil then return title end

				-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
				-- In this case a note with the title 'My new note' will be given an ID that looks
				-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
				local suffix = ""
				if title ~= nil then
					-- If title is given, transform it into valid file name.
					suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
				else
					-- If title is nil, just add 4 random uppercase letters to the suffix.
					for _ = 1, 4 do
						suffix = suffix .. string.char(math.random(65, 90))
					end
				end
				return tostring(os.time()) .. "-" .. suffix
			end,

			note_frontmatter_func = function(note)
				if note.title then note:add_alias(note.title) end

				local frontmatter = { id = note.id, aliases = note.aliases, tags = note.tags }

				if not note:has_tag "daily_notes" then frontmatter["title"] = note.title end

				-- `note.metadata` contains any manually added fields in the frontmatter.
				-- So here we just make sure those fields are kept in the frontmatter.
				if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
					for k, v in pairs(note.metadata) do
						frontmatter[k] = v
					end
				end

				return frontmatter
			end,

			daily_notes = {
				folder = "daily",
				alias_format = "%d-%m-%Y",
				template = "daily.md",
				default_tags = { "daily_notes" },
			},

			templates = {
				folder = "templates",
				date_format = "%d-%m-%Y",
				time_format = "%H:%M",
			},

			attachments = {
				img_folder = "assets",
			},

			ui = {
				hl_groups = {
					ObsidianTodo = { link = "GruvboxOrangeBold" },
					ObsidianDone = { link = "GruvboxGreenBold" },
					ObsidianRightArrow = { link = "GruvboxOrangeBold" },
					ObsidianTilde = { link = "GruvboxPurpleBold" },
					ObsidianImportant = { link = "GruvboxRedBold" },
					ObsidianBullet = { link = "GruvboxBlue" },
					ObsidianRefText = { link = "GruvboxPurpleUnderline" },
					ObsidianExtLinkIcon = { link = "GruvboxPurple" },
					ObsidianTag = { link = "GruvboxBlue", italic = true },
					ObsidianBlockID = { link = "GruvboxBlue", italic = true },
					ObsidianHighlightText = { link = "GruvboxGreen" },
				},
			},

			mappings = {
				["gf"] = {
					action = function() return require("obsidian").util.gf_passthrough() end,
					opts = { noremap = false, expr = true, buffer = true },
				},
			},
		},
	},
}
