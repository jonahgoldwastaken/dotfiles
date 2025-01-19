local indent = 4
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.autoread = true
vim.o.completeopt = "menu,menuone,noinsert,fuzzy"
vim.o.conceallevel = 3
vim.o.confirm = true
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.formatoptions = "jcroqlnt"
vim.o.grepformat = "%f:%l:%c:%m"
vim.o.grepprg = "rg --vimgrep"
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "split"
vim.o.laststatus = 0
vim.o.linebreak = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.pumheight = 20
vim.o.scrolloff = 5
vim.o.sidescrolloff = 5
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help" }
vim.o.shiftround = true
vim.o.shiftwidth = indent
vim.opt.shortmess:append { w = true, I = true, c = true }
vim.o.showmode = false
vim.o.sidescrolloff = 5
vim.o.signcolumn = "yes"
vim.o.smartindent = true
vim.o.softtabstop = indent
vim.opt.spelllang = { "en_gb", "nl" }
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.tabstop = indent
vim.o.termguicolors = true
vim.o.timeoutlen = 500
vim.o.undofile = true
vim.o.undolevels = 10000
vim.o.updatetime = 200
vim.o.wrap = false
vim.wo.foldlevel = 99
vim.o.mouse = ""
vim.o.backup = true
vim.o.cmdheight = 1
vim.o.backupdir = vim.fn.stdpath "state" .. "/backup"
vim.o.splitkeep = "screen"
vim.opt.shortmess:append { C = true }

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

vim.o.termsync = true

-- fix markdown indentation settings
vim.g.markdown_recommended_style = 0
