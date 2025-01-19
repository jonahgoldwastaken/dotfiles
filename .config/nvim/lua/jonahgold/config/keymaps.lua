local opts = { silent = true, noremap = true }

local function keymap(mode, keys, cmd, o)
	o = o or {}
	vim.keymap.set(mode, keys, cmd, vim.tbl_extend("keep", o, opts))
end

-- Replace highlighted text with register content
keymap("v", "p", "\"_dP")

--Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap("v", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("v", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move Lines
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Better indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Highlights under cursor
keymap("n", "<leader>hl", vim.show_pos, { desc = "Highlight Groups at cursor" })

-- Windows
keymap("n", "<leader>ww", "<C-W>p", { desc = "other-window" })
keymap("n", "<leader>wd", "<C-W>c", { desc = "delete-window" })
keymap("n", "<leader>w-", "<C-W>s", { desc = "split-window-below" })
keymap("n", "<leader>w|", "<C-W>v", { desc = "split-window-right" })

-- Lazy
keymap("n", "<leader>l", "<cmd>:Lazy<cr>")

-- Mason
keymap("n", "<leader>m", "<cmd>:Mason<cr>")

-- Clear search with <esc>
keymap({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")
keymap("n", "gw", "*N")
keymap("x", "gw", "*N")

-- Copy and paste to/from pasteboard
keymap("x", "<leader>Y", "\"+Y", { desc = "Copy to pasteboard" })
keymap("x", "<leader>y", "\"+y", { desc = "Copy to pasteboard" })
keymap("x", "<leader>p", "\"+p", { desc = "Paste from pasteboard" })
keymap("x", "<leader>P", "\"+P", { desc = "Paste from pasteboard" })
keymap("n", "<leader>Y", "\"+Y", { desc = "Copy to pasteboard" })
keymap("n", "<leader>y", "\"+y", { desc = "Copy to pasteboard" })
keymap("n", "<leader>p", "\"+p", { desc = "Paste from pasteboard" })
keymap("n", "<leader>P", "\"+P", { desc = "Paste from pasteboard" })

-- Unset arrows
keymap("x", "<up>", "<nop>")
keymap("x", "<down>", "<nop>")
keymap("x", "<left>", "<nop>")
keymap("x", "<right>", "<nop>")
keymap("x", "<ScrollWheelUp>", "<nop>")
keymap("x", "<ScrollWheelDown>", "<nop>")
