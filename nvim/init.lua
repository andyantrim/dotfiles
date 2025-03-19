-- Import settings and run the pre setup stuff
local settings = require('settings')
settings.pre()

-- Setup plugins with config in lua/plugins.lua
local plugs = require('plugins')
require('lazy').setup(plugs, {})

-- See `:help vim.o`
settings.post()
-- [[ Basic Keymaps ]] require('keymaps') Keymaps for better default experience
-- See `:help vim.keymap.set()`
require('keymaps')


vim.defer_fn(function()
	pcall(vim.cmd.colorscheme, "tokyonight-day")
end, 20)  -- Slight delay to ensure plugins are loaded

