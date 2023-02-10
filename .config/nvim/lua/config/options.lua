local indent = 2
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.hidden = true
vim.opt.showmode = false
vim.opt.clipboard = "unnamed,unnamedplus"
vim.opt.confirm = true
vim.opt.autoread = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.expandtab = false
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftround = true
vim.opt.shiftwidth = indent
vim.opt.tabstop = indent
vim.opt.softtabstop = indent
vim.opt.spelllang = { "en_gb", "nl" }
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"
vim.opt.formatoptions = "jcroqlnt"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
vim.opt.termguicolors = true
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.updatetime = 200
vim.opt.timeoutlen = 300
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.pumheight = 10
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8
vim.opt.conceallevel = 3
vim.opt.laststatus = 0
vim.opt.cmdheight = 0
vim.opt.joinspaces = false
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.wrap = true

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

if vim.fn.has "nvim-0.9.0" == 1 then
	vim.o.shortmess = "filnxtToOFIcC"
	vim.opt.splitkeep = "screen"
end

-- fix markdown indentation settings
vim.g.markdown_recommended_style = 0
