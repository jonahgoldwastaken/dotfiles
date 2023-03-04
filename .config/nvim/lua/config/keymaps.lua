local opts = { silent = true, noremap = true }

local function keymap(mode, keys, cmd, o)
	o = o or {}
	vim.keymap.set(mode, keys, cmd, vim.tbl_extend("keep", o, opts))
end

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==")
keymap("v", "<A-k>", ":m .-2<CR>==")
keymap("v", "p", "\"_dP")

--Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap("v", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("v", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move Lines
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- better indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

keymap("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Open Location List" })
keymap("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Open Quickfix List" })

-- highlights under cursor
if vim.fn.has "nvim-0.9.0" == 1 then
	keymap("n", "<leader>hl", vim.show_pos, { desc = "Highlight Groups at cursor" })
end

-- windows
keymap("n", "<leader>ww", "<C-W>p", { desc = "other-window" })
keymap("n", "<leader>wd", "<C-W>c", { desc = "delete-window" })
keymap("n", "<leader>w-", "<C-W>s", { desc = "split-window-below" })
keymap("n", "<leader>w|", "<C-W>v", { desc = "split-window-right" })

-- lazy
keymap("n", "<leader>l", "<cmd>:Lazy<cr>")

-- mason
keymap("n", "<leader>m", "<cmd>:Mason<cr>")

-- quit
keymap("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- Clear search with <esc>
keymap({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")
keymap("n", "gw", "*N")
keymap("x", "gw", "*N")

keymap("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
keymap("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Resize window using <shift> arrow keys
keymap("n", "<S-Up>", "<cmd>resize +2<CR>")
keymap("n", "<S-Down>", "<cmd>resize -2<CR>")
keymap("n", "<S-Left>", "<cmd>vertical resize -2<CR>")
keymap("n", "<S-Right>", "<cmd>vertical resize +2<CR>")

-- Move to window using the <meta> movement keys
keymap("n", "<A-left>", "<C-w>h")
keymap("n", "<A-down>", "<C-w>j")
keymap("n", "<A-up>", "<C-w>k")
keymap("n", "<A-right>", "<C-w>l")

-- tabs
keymap("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last" })
keymap("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First" })
keymap("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
keymap("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next" })
keymap("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close" })
keymap("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous" })
