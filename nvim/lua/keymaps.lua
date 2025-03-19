local telescope = require('telescope')
local builtin = require('telescope.builtin')

-- LSP references and definitions are already built into telescope.builtin
-- No need to create custom extensions for these

-- Telescope LSP shortcuts
vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions, { desc = 'LSP: Go to definition' })
vim.keymap.set('n', '<leader>gr', builtin.lsp_references, { desc = 'LSP: Find references' })
vim.keymap.set('n', '<leader>gi', builtin.lsp_implementations, { desc = 'LSP: Go to implementation' })
vim.keymap.set('n', '<leader>gt', builtin.lsp_type_definitions, { desc = 'LSP: Go to type definition' })
vim.keymap.set('n', '<leader>gs', builtin.lsp_document_symbols, { desc = 'LSP: Document symbols' })
vim.keymap.set('n', '<leader>gw', builtin.lsp_workspace_symbols, { desc = 'LSP: Workspace symbols' })

-- Telescope shortcuts
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', telescope.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>sg', telescope.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>sw', telescope.grep_string, { desc = 'Telescope find word' })
vim.keymap.set('n', '<leader>sb', telescope.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>so', telescope.jumplist, { desc = 'Telescope jumplist' }) -- Searches through CTRL+o
vim.keymap.set('n', '<leader>sh', telescope.help_tags, { desc = 'Telescope help tags' })

-- Nvim Tree
local api = require('nvim-tree.api')
vim.keymap.set('n', '<C-n>', api.tree.toggle, { desc = 'Open file tree' })
vim.keymap.set('n', '<leader>nf', api.tree.find_file, { desc = 'Open file tree at current file' })

-- Buffers are dead, long live fake tabs
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { noremap = true, silent = true, desc = "Go to next buffer" })
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', { noremap = true, silent = true, desc = "Go to previous buffer" })
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { noremap = true, silent = true, desc = "Delete current buffer" })
vim.keymap.set('n', '<leader>bl', ':Telescope buffers<CR>', { noremap = true, silent = true, desc = "List all buffers" })
for i = 1, 9 do
	vim.keymap.set('n', '<leader>b' .. i, ':buffer ' .. i .. '<CR>',
		{ noremap = true, silent = true, desc = "Go to buffer " .. i })
end

-- AI stuff
vim.keymap.set('n', '<leader>aa', ':AvanteAsk<CR>', { noremap = true, silent = true, desc = "Ask the AI" })
vim.keymap.set('n', '<leader>aa', ':AvanteEdit<CR>', { noremap = true, silent = true, desc = "Get AI to edit the code" })
