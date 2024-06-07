vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

local dapui = require("dapui")
local dap = require("dap")
local pydap = require("dap-python")
local godap = require("dap-go")

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>d[', vim.diagnostic.goto_prev, { desc = "Go to [P]revious [D]iagnostic message" })
vim.keymap.set('n', '<leader>d]', vim.diagnostic.goto_next, { desc = "Go to [N]ext [D]iagnostic message" })
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
vim.keymap.set('n', "<leader>du", dapui.toggle, {desc = "Dap UI" })
vim.keymap.set('n', "<leader>de", dapui.eval, {desc = "Eval"})
vim.keymap.set('n', "<leader>dt", dap.toggle_breakpoint, {desc = "Toggle breakpoint" })
vim.keymap.set('n', "<leader>dc", dap.continue, {desc = "Continue" })
vim.keymap.set('n', "<leader>dq", dap.terminate,{ desc = "terminate" })
vim.keymap.set('n', "<leader>di", dap.step_into,{ desc = "step into" })
vim.keymap.set('n', "<leader>do", dap.step_out, {desc = "step out" })
vim.keymap.set('n', "<leader>dp", dap.step_over, {desc = "step past" })
vim.keymap.set('n', "<leader>db", dap.step_back, {desc = "step back" })
vim.keymap.set('n', "<leader>ddpt", pydap.test_method, {desc = "Test python method" })
vim.keymap.set('n', "<leader>ddgt", godap.debug_test, {desc = "Test go function" })

-- File tree
local nvimapi = require('nvim-tree.api')

-- Set up bad buffer management
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = "Next buffer" })
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', { desc = "Previous buffer" })
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { desc = "Delete buffer" })


-- File tree config
vim.keymap.set('n', '<C-n>', nvimapi.tree.toggle, { desc = "Toggle the file tree"})
vim.keymap.set('n', '<leader>nf', ':NvimTreeFindFile<CR>:NvimTreeFocus<CR>', { desc = "Find Filfe in the file tree" })

-- Weird AI stuff with enhanced keybindings for quick Actions
vim.keymap.set({ 'n', 'v' }, '<leader>af', ':Gen Change_Code<CR>') -- Apply Code Changes
vim.keymap.set({ 'n', 'v' }, '<leader>ac', ':Gen Chat<CR>')          -- Generate AI-driven Chat Message
vim.keymap.set({ 'n', 'v' }, '<leader>ae', ':Gen Enhance_Code<CR>') -- Display AI message in terminal or Neovim terminal

vim.keymap.set({ 'n', 'v' }, '<leader>a?', ':LlamaCopilotComplet<CR>') -- Apply Code Changes
vim.keymap.set({ 'n', 'v' }, '<leader>aa', ':LlamaCopilotAccept<CR>')          -- Generate AI-driven Chat Message
vim.keymap.set({ 'n', 'v' }, '<leader>ae', ':Gen Enhance_Code<CR>') -- Display AI message in terminal or Neovim terminal
