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
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		}
	},
	virtual_text = {
		prefix = " "
	}
})

-- require this require that...
require("lazy").setup({
	spec = {
		{ 'Shatur/neovim-ayu' },
		{ 'IogaMaster/neocord', event = "VeryLazy" },
		{ 'norcalli/nvim-colorizer.lua' },
		{
			'neovim/nvim-lspconfig',
			dependencies = { 'saghen/blink.cmp' },
		},
		{
			'saghen/blink.cmp',
			dependencies = { 'rafamadriz/friendly-snippets' },
			version = '1.*',
			opts = {
				keymap = {
					preset = 'default',
			},
				appearance = {
					nerd_font_variant = 'mono'
				},
				completion = {
					menu = {
						draw = {
							columns = {
								{
									"kind_icon",
									"label",
									"label_description",
									gap = 1,
								},
								{"kind"}
							},
							gap = 10
						}
					},
					documentation = {
						auto_show = false,
					},
					ghost_text = {
						enabled = true
					}
				},
				sources = {
					default = { 'lsp', 'path', 'snippets', 'buffer' },
				},
				fuzzy = { implementation = "prefer_rust_with_warning" },
			},
			opts_extend = { "sources.default" },
		},
		{ 'lukas-reineke/indent-blankline.nvim' },
		{
			'goolord/alpha-nvim',
		         config = function ()
				local alpha = require'alpha'
				local dashboard = require'alpha.themes.dashboard'
				local section = dashboard.section
				local fn = vim.fn
				local config = dashboard.config
				 dashboard.section.header.val = {
				[[ __   __     __   __   __     __    __]],
				[[/\ "-.\ \   /\ \ / /  /\ \   /\ "-./  \]],
				[[\ \ \-.  \  \ \ \'/   \ \ \  \ \ \-./\ \]],
				[[ \ \_\\"\_\  \ \__|    \ \_\  \ \_\ \ \_\]],
				[[  \/_/ \/_/   \/_/      \/_/   \/_/  \/_/]],
				}
				dashboard.section.header.opts.hl = "Exception"
				dashboard.section.buttons.val = {
					 dashboard.button( "E", "  New file" , ":ene <BAR> startinsert <CR>"),
					 dashboard.button( "Space + FF", "󰈞  Find file", ":Telescope find_files cwd=/home<CR>" ),
					 dashboard.button ("Space + FO", "󰈢  Recently opened files", ":Telescope oldfiles<CR>"),
					 dashboard.button( "q", "󰅚  Quit NVIM" , ":qa<CR>"),
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
			dependencies = { 'nvim-lua/plenary.nvim' }
		},
		{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
		{
			'windwp/nvim-autopairs',
			event = "InsertEnter",
			config = true
		},
		{
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
		},
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
		},
	})
	vim.cmd("colorscheme ayu-mirage")
--

require('neocord').setup({})
require('colorizer').setup()
require('ibl').setup()
-- Telescope
	require('telescope').setup({
		pickers = {
			find_files = {
				hidden = true
			}
		},
		defaults = {
			file_ignore_patterns = {
				"%.dump", "%.log", "%.tmp", "node_modules", "%.o", "%.class"
			}
		}
	})
	-- Telescope Keybinds
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', function()
			builtin.find_files({ cwd = "/home" })
		end, { desc = 'Telescope find files in /home' })
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
		vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Telescope oldfiles' })
	--
--
require("mason").setup()
require("mason-lspconfig").setup()
