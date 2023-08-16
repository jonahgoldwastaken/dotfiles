local indent = 4
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.autoread = true
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.conceallevel = 3
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.formatoptions = "jcroqlnt"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"
vim.opt.laststatus = 0
vim.opt.linebreak = true
vim.opt.number = true
vim.opt.pumheight = 10
vim.opt.relativenumber = true
vim.opt.scrolloff = 5
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
vim.opt.shiftround = true
vim.opt.shiftwidth = indent
vim.opt.shortmess:append { w = true, I = true, c = true }
vim.opt.showmode = false
vim.opt.sidescrolloff = 5
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = indent
vim.opt.spelllang = { "en_gb", "nl" }
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = indent
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 200
vim.opt.wrap = false

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

if vim.fn.has "nvim-0.8" == 1 then
	vim.opt.backup = true
	vim.opt.cmdheight = 0
	vim.opt.backupdir = vim.fn.stdpath "state" .. "/backup"
end

if vim.fn.has "nvim-0.9.0" == 1 then
	vim.opt.splitkeep = "screen"
	vim.opt.shortmess:append { C = true }
end

-- fix markdown indentation settings
vim.g.markdown_recommended_style = 0
