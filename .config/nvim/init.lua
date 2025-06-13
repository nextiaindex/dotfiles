local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.confirm = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.diagnostic.config({
	virtual_text = {
		prefix = " "
	},
	underline = true,
	update_in_insert = false,
	signs = false
})
vim.opt.termguicolors = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- require this require that...
require("lazy").setup({
	spec = {
		{
			'Shatur/neovim-ayu',
		},

		{
			'IogaMaster/neocord',
			event = "VeryLazy",
			opts = {
				logo                = "auto",
				logo_tooltip        = nil,
				main_image          = "language",
				client_id           = "1157438221865717891",
				log_level           = nil,
				debounce_timeout    = 10,
				blacklist           = {},
				file_assets         = {},
				show_time           = true,
				global_timer        = false,
				buttons             = nil,

				-- Rich Presence text options
				editing_text        = "Editing %s",
				file_explorer_text  = "Browsing %s",
				git_commit_text     = "Committing changes",
				plugin_manager_text = "Managing plugins",
				reading_text        = "Reading %s",
				workspace_text      = "Working on %s",
				line_number_text    = "Line %s out of %s",
				terminal_text       = "Using Terminal",

			}
		},

		{
			'norcalli/nvim-colorizer.lua'
		},

		{
			'neovim/nvim-lspconfig',
			dependencies = { 'saghen/blink.cmp' },
		},

		{
			'saghen/blink.cmp',
			dependencies = { 'rafamadriz/friendly-snippets' },
			opts = {
				keymap = {preset = 'super-tab'},
				appearance = {nerd_font_variant = 'mono'},
				completion = {
					menu = {
						draw = {
							align_to = 'cursor',
							columns = {
								{
									"kind_icon",
									"label",
									gap = 1
								}
							},
							gap = 10,
						}
					},
					documentation = {auto_show = false},
					ghost_text = {enabled = true}
				},
				sources = {
					providers = {
						lsp = {
							enabled = function ()
								local clients = vim.lsp.get_active_clients({bufnr = vim.api.nvim_get_current_buf()})
								return #clients > 0
							end
						},
						path = {
							enabled = function ()
								local clients = vim.lsp.get_active_clients({bufnr = vim.api.nvim_get_current_buf()})
								return #clients > 0
							end
						},
						snippets = {
							enabled = function ()
								local clients = vim.lsp.get_active_clients({bufnr = vim.api.nvim_get_current_buf()})
								return #clients > 0
							end
						},
						buffer = {
							enabled = function ()
								local clients = vim.lsp.get_active_clients({bufnr = vim.api.nvim_get_current_buf()})
								return #clients > 0
							end
						}
					}
				},
				fuzzy = { implementation = "lua" },
			},
			opts_extend = {"sources.default"},
		},

		{
			"shellRaining/hlchunk.nvim",
			opts = {
				indent = {enable = true}
			}
		},

		{
			'goolord/alpha-nvim',
		        config = function ()
					local alpha = require'alpha'
					local dashboard = require'alpha.themes.dashboard'
					local section = dashboard.section
					local fn = vim.fn
					local config = dashboard.config
					 dashboard.section.header.val = {
						[[ __   __     __   __   __     __    __    ]],
						[[/\ "-.\ \   /\ \ / /  /\ \   /\ "-./  \   ]],
						[[\ \ \-.  \  \ \ \'/   \ \ \  \ \ \-./\ \  ]],
						[[ \ \_\\"\_\  \ \__|    \ \_\  \ \_\ \ \_\ ]],
						[[  \/_/ \/_/   \/_/      \/_/   \/_/  \/_/ ]]
					}
					dashboard.section.header.opts.hl = "Exception"
					dashboard.section.buttons.val = {
						 dashboard.button( "n", "  New file" , ":ene <BAR> startinsert <CR>"),
						 dashboard.button( "<Space> + ff", "󰈞  Find file", ":Telescope find_files <CR>"),
						 dashboard.button ("<Space> + fo", "󰈢  Recently opened files", ":Telescope oldfiles<CR>"),
						 dashboard.button( "q", "󰅚  Quit Neovim" , ":qa<CR>"),
					}
					local handle = io.popen('fortune')
					local fortune = handle:read("*a")
					handle:close()
					dashboard.section.footer.val = fortune

					dashboard.config.opts.noautocmd = true

					vim.cmd[[autocmd User AlphaReady echo 'ready']]
					local marginTopPercent = 0.3
					local headerPadding = fn.max({2, fn.floor(fn.winheight(0) * marginTopPercent) })

					config.layout = {
						{ type = 'padding', val = headerPadding },
						section.header,
						{ type = 'padding', val = 2 },
						section.buttons,
						section.footer,
					}
					alpha.setup(dashboard.config)
			end
		},

		{
			'nvim-telescope/telescope.nvim', tag = '0.1.8',
			dependencies = { 'nvim-lua/plenary.nvim' },
			config = true

		},

		{
			"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"
		},

		{
			'windwp/nvim-autopairs',
			event = "InsertEnter",
			config = true
		},

		{
			"mason-org/mason.nvim",
			config = true
		},

		{
			"neovim/nvim-lspconfig"
		},

		{
			"rcarriga/nvim-notify"
		},

		{
			"nvim-tree/nvim-tree.lua",
			dependencies = {
				"nvim-tree/nvim-web-devicons"
			},
			config = true
		}
	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = true },
})

-- Ayu Mirage
	require('ayu').setup({
		mirage = true,
		terminal = true,
		overrides = {
			LineNr = { fg = "gray" },
			CursorLineNr = { fg = "#f28779" },
		}
	})
	vim.cmd("colorscheme ayu-mirage")
--

require('colorizer').setup()
	-- Telescope Keybinds
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files'})
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
		vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Telescope oldfiles' })
	--
--
-- nvim-notify
	vim.notify = require("notify")
	require("notify").setup({
		render = "wrapped-compact",
		stages = "static",
	})
--

vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>')

-- LSP Config Override
	local lspconfig = require('lspconfig')

	lspconfig.lua_ls.setup {
		cmd = { 'lua-language-server' },
		filetypes = { 'lua' },
		root_markers = {
			'.luarc.json',
			'.luarc.jsonc',
			'.luacheckrc',
			'.stylua.toml',
			'stylua.toml',
			'selene.toml',
			'selene.yml',
			'.git',
		},
		on_init = function(client)
			if client.workspace_folders then
				local path = client.workspace_folders[1].name
				if
					path ~= vim.fn.stdpath('config')
					and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
					then
						return
					end
				end

				client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
					runtime = {
						version = 'LuaJIT',
						path = {
							'lua/?.lua',
							'lua/?/init.lua',
						},
					},
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME
						}
					}
				})
			end,
			settings = {
				Lua = {}
			}
		}
	lspconfig.html.setup {
		cmd = { 'vscode-html-language-server', '--stdio' },
		filetypes = { 'html', 'templ' },
		root_markers = { 'package.json', '.git' },
		settings = {},
		init_options = {
			provideFormatter = true,
			embeddedLanguages = { css = true, javascript = true },
			configurationSection = { 'html', 'css', 'javascript' },
		},
	}
	lspconfig.cssls.setup {
		cmd = { 'vscode-css-language-server', '--stdio' },
		filetypes = { 'css', 'scss', 'less' },
		init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
		root_markers = { 'package.json', '.git' },
		settings = {
			css = { validate = true },
			scss = { validate = true },
			less = { validate = true },
		},
	}
--
