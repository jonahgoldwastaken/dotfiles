---@diagnostic disable: missing-fields
return {
	"epwalsh/obsidian.nvim",
	version = "*",
	cmd = { "ObsidianWorkspace", "ObsidianNew", "ObsidianToday" },
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

		---@param title string|?
		---@return string
		note_id_func = function(title)
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
	},
}
