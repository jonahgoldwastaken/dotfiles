vim.loader.enable()

require "jonahgold.config.options"
require "jonahgold.config.autocmds"
require "jonahgold.config.keymaps"
require "jonahgold.config.settings"
require "jonahgold.config.lazy"

if require("jonahgold.util").in_work_dir() then require "jonahgold.work.commands" end
