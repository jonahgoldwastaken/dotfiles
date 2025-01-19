vim.api.nvim_create_augroup("Jonahgold", { clear = true })

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd(
	{ "FocusGained", "TermClose", "TermLeave" },
	{ group = "Jonahgold", command = "checktime" }
)

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = "Jonahgold",
	pattern = {
		"qf",
		"help",
		"man",
		"notify",
		"lspinfo",
		"startuptime",
		"oil",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = "Jonahgold",
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = "Jonahgold",
	callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = "Jonahgold",
	pattern = { "json", "jsonc" },
	callback = function()
		vim.wo.spell = false
		vim.wo.conceallevel = 0
	end,
})
