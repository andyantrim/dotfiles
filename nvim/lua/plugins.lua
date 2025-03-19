PluginConfig = {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		opts = {
			defaults = {
				mappings = {
					i = {
						-- Delete buffer while in insert mode with <C-d>
						["<C-d>"] = "delete_buffer",
					},
					n = {
						-- Delete buffer while in normal mode with 'd'
						["d"] = "delete_buffer",
					}
				},
			}
		}
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = { "lua", "vim", "vimdoc", "query", "go", "java", "javascript", "html" },
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end
	},
	{
		'neovim/nvim-lspconfig',
		lazy = false,
		priority = 80, -- Load after mason and mason-lspconfig
	},
	{
		"williamboman/mason.nvim",
		lazy = false,
		priority = 100, -- Make mason load early
		config = function()
			require("mason").setup()
		end,
		opts = {
			ensure_installed = {
				"stylua",
				"shellcheck",
				"shfmt",
				"gopls",
				"handlers",
				"jdtls", -- Added Java language server
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim", -- Add this plugin to connect Mason with lspconfig
		lazy = false,
		priority = 90,         -- Load after mason but before LSP setup
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"gopls",
					"jdtls", -- Ensure Java LSP is installed through mason-lspconfig
				},
				automatic_installation = true,
			})
		end,
	},
	{
		'saghen/blink.cmp',
		dependencies = {
			'rafamadriz/friendly-snippets',
			'neovim/nvim-lspconfig',
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
		},
		version = 'v0.13.0',
		opts = {
			keymap = { preset = 'enter' },
			appearance = {
				nerd_font_variant = 'mono'
			},
			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer' },
			},

			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
		config = function(_, opts)
			-- Setup diagnostics with visual indicators
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			-- Set up LSP signs for error highlighting
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			local blink = require('blink.cmp')
			local capabilities = blink.get_lsp_capabilities()

			-- Set up on_attach function to use for each LSP server
			local on_attach = function(client, bufnr)
				-- You can add custom LSP-specific keybindings here
				-- Example:
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
					{ buffer = bufnr, desc = "Go to declaration" })
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
					{ buffer = bufnr, desc = "Go to definition" })
				vim.keymap.set('n', 'K', vim.lsp.buf.hover,
					{ buffer = bufnr, desc = "Show hover information" })
			end

			-- Configure LSP servers using mason-lspconfig
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
						flags = {
							debounce_text_changes = 150,
						}
					})
				end,

				-- You can add custom server configurations here
				["jdtls"] = function()
					require("lspconfig").jdtls.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = {
							java = {
								signatureHelp = { enabled = true },
								contentProvider = { preferred = 'fernflower' },
								completion = {
									favoriteStaticMembers = {
										"org.junit.Assert.*",
										"org.junit.Assume.*",
										"org.junit.jupiter.api.Assertions.*",
										"org.junit.jupiter.api.Assumptions.*",
										"org.junit.jupiter.api.DynamicContainer.*",
										"org.junit.jupiter.api.DynamicTest.*",
										"org.mockito.Mockito.*",
										"org.mockito.ArgumentMatchers.*",
									},
								},
								configuration = {
									updateBuildConfiguration = "interactive",
									runtimes = {
										{
											name = "JavaSE-11",
											path = "/path/to/java-11", -- Change this path to your Java 11 home
										},
										{
											name = "JavaSE-17",
											path = "/path/to/java-17", -- Change this path to your Java 17 home
										},
									},
								},
							},
						},
					})
				end,
			})

			blink.setup(opts)
		end
	},
	{
		'nvim-tree/nvim-tree.lua',
		dependencies = 'nvim-tree/nvim-web-devicons',
		config = function(_)
			require('nvim-tree').setup()
		end
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				-- Optional: Specify a specific style
				style = "storm", -- or "night", "moon", "day"
				transparent = false,
				terminal_colors = true,
			})
		end,
	},
	{ 'folke/which-key.nvim',    lazy = true },
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = {
			{
				"<leader>dt",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>ds",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
		}
	},
	{ 'akinsho/toggleterm.nvim', version = "*", config = true },
	{
		'stevearc/conform.nvim',
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "isort", "black" },
				-- Conform will run the first available formatter
				javascript = { "prettierd", "prettier", stop_after_first = true },
				go = { "gopls", lsp_fallback = true },
				java = { "jdtls", lsp_fallback = true }, -- Add Java formatting
			},
		},
	},
	{
		'akinsho/bufferline.nvim',
		version = "*",
		dependencies = { 'nvim-tree/nvim-web-devicons', "catppuccin/nvim" },
		config = function()
			vim.opt.termguicolors = true
			require('bufferline').setup {
				highlights = require("catppuccin.groups.integrations.bufferline").get()
			}
		end
	},
	"nvim-treesitter/nvim-treesitter-context",
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = "v0.0.23", -- Never set this value to "*"! Never!
		opts = {
			provider = "ollama",
			vendors = {
				ollama = {
					endpoint = "http://127.0.0.1:11434/v1", -- Note that there is no /v1 at the end.
					model = "gemma3:12b",
					__inherited_from = "openai",
					api_key_name = "",
					disable_tools = true,
				},
			},
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"echasnovski/mini.pick", -- for file_selector provider mini.pick
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			"ibhagwan/fzf-lua", -- for file_selector provider fzf
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to set this up properly if you have lazy=true
				'MeanderingProgrammer/render-markdown.nvim',
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	}
}

return PluginConfig
